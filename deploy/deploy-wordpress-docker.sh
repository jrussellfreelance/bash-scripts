#!/bin/bash
# Tested on Ubuntu 18.04
# This script deploys Nextcloud via docker
# Grab variables from user
while [[ -z "$hostport" ]]
do
    read -p "host port >> " hostport
done
while [[ -z "$phpport" ]]
do
    read -p "phpmyadmin port >> " hostport
done
while [[ -z "$domain" ]]
do
    read -p "wordpress domain >> " domain
done
# Generate passwords
mysql_db_pwd=$(date +%s | sha256sum | base64 | head -c 14 ; echo)
mysql_root_pwd=$(date +%s | sha256sum | base64 | head -c 14 ; echo)

# Create linked directories
mkdir -p wordpress/$domain/wp-content
cd wordpress/$domain

# Create uploads.ini
cat <<'EOF' > uploads.ini
memory_limit=2048M
upload_max_filesize=2048M
post_max_size=2048M
max_execution_time=300
EOF

# Create docker-compose file
cat <<'EOF' > docker-compose.yml
version: '2'
services:
   wordpress:
     depends_on:
       - db
     image: wordpress
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: @@@mysql_db_pwd@@@
       WORDPRESS_DB_NAME: wordpress
     ports:
       - "@@@hostport@@@:80"
     networks:
       - wordpress_network
     working_dir: /var/www/html
     volumes:
       - ./wp-content:/var/www/html/wp-content
       - ./uploads.ini:/usr/local/etc/php/conf.d/uploads.ini
   db:
     image: mariadb
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: @@@mysql_root_pwd@@@
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD: @@@mysql_db_pwd@@@
     networks:
       - wordpress_network
     volumes:
       - db_data:/var/lib/mysql

   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: @@@mysql_db_pwd@@@
       WORDPRESS_DB_NAME: wordpress
     ports:
       - "@@@hostport@@@:80"
     networks:
       - wordpress_network
     working_dir: /var/www/html
     volumes:
       - ./wp-content:/var/www/html/wp-content
       - ./uploads.ini:/usr/local/etc/php/conf.d/uploads.ini
   phpmyadmin:
     depends_on:
       - db
     image: phpmyadmin
     restart: always
     environment:
       PMA_HOST: db
       MYSQL_ROOT_PASSWORD: @@@mysql_db_pwd@@@
     ports:
       - "@@@phpport@@@:80"
     networks:
       - wordpress_network
volumes:
    db_data: {}
EOF

# replace placeholder values with bash variables
sed -i "s/@@@hostport@@@/${hostport}/g" docker-compose.yml
sed -i "s/@@@phpport@@@/${phpport}/g" docker-compose.yml
sed -i "s/@@@mysql_root_pwd@@@/${mysql_root_pwd}/g" docker-compose.yml
sed -i "s/@@@mysql_db_pwd@@@/${mysql_db_pwd}/g" docker-compose.yml

# start docker compose stack
docker-compose up -d
