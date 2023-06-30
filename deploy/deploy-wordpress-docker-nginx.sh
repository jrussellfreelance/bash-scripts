#!/bin/bash
# tested on Ubuntu 22.04
# this script deploys Wordpress w/ Nginx via Docker Compose

# grab variables
while [[ -z "$domain" ]]
do
    read -p "wordpress domain >> " domain
done
while [[ -z "$hostport" ]]
do
    read -p "host port (https) >> " hostport
done
while [[ -z "$phpport" ]]
do
    read -p "phpmyadmin port >> " phpport
done

# generate passwords
mysql_db_pwd=$(date +%s | sha256sum | base64 | head -c 17 ; echo)
sleep 1 # wait a second to get a different password
mysql_root_pwd=$(date +%s | sha256sum | base64 | head -c 17 ; echo)

# store user and group IDs
user_id="$(id -u)"
group_id="$(id -g)"

# create linked directories
mkdir -p wordpress/$domain/{site_files,nginx_conf}
cd wordpress/$domain

# create uploads.ini
cat <<'EOF' > uploads.ini
memory_limit = 2048M
upload_max_filesize = 2048M
post_max_size = 2048M
max_execution_time = 300
EOF

# create Nginx conf
cat <<'EOF' > ./nginx_conf/$domain.conf
server {
  listen 80;
  listen [::]:80;
  server_name @@@domain@@@ www.@@@domain@@@;
  location ~ /.well-known/acme-challenge {
          allow all;
          root /var/www/html;
  }
  location / {
          rewrite ^ https://$host$request_uri? permanent;
  }
}
server {
  listen 443 ssl http2;
  listen [::]:443 ssl http2;
  server_name @@@domain@@@ www.@@@domain@@@;
  index index.php index.html index.htm;
  root /var/www/html;
  server_tokens off;
  # add our paths for the certificates Certbot created
  ssl_certificate /etc/letsencrypt/live/@@@domain@@@/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/@@@domain@@@/privkey.pem;
  # some security headers ( optional )
  add_header X-Frame-Options "SAMEORIGIN" always;
  add_header X-XSS-Protection "1; mode=block" always;
  add_header X-Content-Type-Options "nosniff" always;
  add_header Referrer-Policy "no-referrer-when-downgrade" always;
  add_header Content-Security-Policy "default-src * data: 'unsafe-eval' 'unsafe-inline'" always;
  location / {
          try_files $uri $uri/ /index.php$is_args$args;
  }
  location ~ \.php$ {
          try_files $uri =404;
          fastcgi_split_path_info ^(.+\.php)(/.+)$;
          fastcgi_pass wordpress:9000;
          fastcgi_index index.php;
          include fastcgi_params;
          fastcgi_param SCRIPT_FILENAME  $document_root$fastcgi_script_name;
          fastcgi_param PATH_INFO $fastcgi_path_info;
  }
  location ~ /\.ht {
          deny all;
  }
   location = /favicon.ico {
          log_not_found off; access_log off;
  }
  location = /favicon.svg {
          log_not_found off; access_log off;
  }
  location = /robots.txt {
          log_not_found off; access_log off; allow all;
  }
  location ~* \.(css|gif|ico|jpeg|jpg|js|png)$ {
          expires max;
          log_not_found off;
  }
}
EOF

# create docker-compose file
cat <<'EOF' > docker-compose.yml
version: '2'
services:
  database:
    image: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: @@@mysql_root_pwd@@@
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpadmin
      MYSQL_PASSWORD: @@@mysql_db_pwd@@@
    volumes:
      - db_data:/var/lib/mysql
  wordpress:
    depends_on:
      - database
    image: wordpress:6.1.1-php8.1-fpm-alpine
    restart: always
    user: "@@@uid@@@:@@@gid@@@"
    working_dir: /var/www/html
    environment:
      WORDPRESS_DB_HOST: database:3306
      WORDPRESS_DB_USER: wpadmin
      WORDPRESS_DB_PASSWORD: @@@mysql_db_pwd@@@
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - type: bind
        source: ./site_files
        target: /var/www/html
      - ./uploads.ini:/usr/local/etc/php/conf.d/uploads.ini
  phpmyadmin:
    depends_on:
      - database
    image: phpmyadmin
    restart: unless-stopped
    ports:
      - @@@phpport@@@:80
    environment:
      PMA_HOST: database
      MYSQL_ROOT_PASSWORD: @@@mysql_root_pwd@@@
  nginx:
    depends_on:
      - wordpress
    image: nginx:stable-alpine
    restart: always
    ports:
      - "@@@hostport@@@:443"
    volumes:
      - type: bind
        source: ./site_files
        target: /var/www/html
      - ./nginx_conf:/etc/nginx/conf.d
      - /etc/ssl/private/@@@domain@@@.key:/etc/letsencrypt/live/@@@domain@@@/privkey.pem
      - /etc/ssl/private/@@@domain@@@.crt:/etc/letsencrypt/live/@@@domain@@@/fullchain.pem
volumes:
  db_data:
EOF

# replace placeholder values with bash variables
sed -i "s/@@@hostport@@@/${hostport}/g" docker-compose.yml
sed -i "s/@@@phpport@@@/${phpport}/g" docker-compose.yml
sed -i "s/@@@mysql_root_pwd@@@/${mysql_root_pwd}/g" docker-compose.yml
sed -i "s/@@@mysql_db_pwd@@@/${mysql_db_pwd}/g" docker-compose.yml
sed -i "s/@@@uid@@@/${user_id}/g" docker-compose.yml
sed -i "s/@@@gid@@@/${group_id}/g" docker-compose.yml
sed -i "s/@@@domain@@@/${domain}/g" docker-compose.yml
sed -i "s/@@@domain@@@/${domain}/g" ./nginx_conf/$domain.conf

# detect correct docker compose binary
if command -v docker-compose > /dev/null; then
  docker_cmd="docker-compose"
else
  docker_cmd="docker compose"
fi

# start the docker compose stack
sudo $docker_cmd up -d

echo " >> https://$domain/ <<"
