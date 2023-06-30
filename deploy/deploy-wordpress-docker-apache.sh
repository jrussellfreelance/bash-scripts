#!/bin/bash
# tested on Ubuntu 22.04
# this script deploys Wordpress w/ Apache via Docker Compose

# grab variables
while [[ -z "$domain" ]]
do
    read -p "wordpress domain >> " domain
done
while [[ -z "$hostport" ]]
do
    read -p "host port >> " hostport
done
while [[ -z "$phpport" ]]
do
    read -p "phpmyadmin port >> " phpport
done

# generate passwords
mysql_db_pwd=$(date +%s | sha256sum | base64 | head -c 14 ; echo)
sleep 1 # wait a second to get a different password
mysql_root_pwd=$(date +%s | sha256sum | base64 | head -c 14 ; echo)

# store user and group IDs
user_id="$(id -u)"
group_id="$(id -g)"

# create linked directories
mkdir -p wordpress/$domain/site_files
cd wordpress/$domain

# create uploads.ini
cat <<'EOF' > uploads.ini
memory_limit = 2048M
upload_max_filesize = 2048M
post_max_size = 2048M
max_execution_time = 300
EOF

# create docker-compose file
cat <<'EOF' > docker-compose.yml
version: '2'
services:
  wordpress:
    image: wordpress
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
    ports:
      - "@@@hostport@@@:80"
    networks:
      - wpnetwork
    depends_on:
      - database
  database:
    image: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: @@@mysql_root_pwd@@@
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpadmin
      MYSQL_PASSWORD: @@@mysql_db_pwd@@@
    networks:
      - wpnetwork
  phpmyadmin:
    image: phpmyadmin
    restart: always
    ports:
      - @@@phpport@@@:80
    environment:
      PMA_HOST: database
      MYSQL_ROOT_PASSWORD: @@@mysql_root_pwd@@@
    networks:
      - wpnetwork
    depends_on:
      - database
networks:
  wpnetwork:
volumes:
  database:
EOF

# replace placeholder values with bash variables
sed -i "s/@@@hostport@@@/${hostport}/g" docker-compose.yml
sed -i "s/@@@phpport@@@/${phpport}/g" docker-compose.yml
sed -i "s/@@@mysql_root_pwd@@@/${mysql_root_pwd}/g" docker-compose.yml
sed -i "s/@@@mysql_db_pwd@@@/${mysql_db_pwd}/g" docker-compose.yml
sed -i "s/@@@uid@@@/${user_id}/g" docker-compose.yml
sed -i "s/@@@gid@@@/${group_id}/g" docker-compose.yml

# detect correct docker compose binary
if command -v docker-compose > /dev/null; then
  docker_cmd="docker-compose"
else
  docker_cmd="docker compose"
fi

# start the docker compose stack
sudo $docker_cmd up -d

echo " >> https://$domain/ <<"
