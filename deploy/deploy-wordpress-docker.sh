#!/bin/bash
# Tested on Ubuntu 18.04
# This script deploys Nextcloud via docker
# Grab variables from user
while [[ -z "$hostport" ]]
do
    read -p "host port >> " hostport
done
while [[ -z "$domain" ]]
do
    read -p "wordpress domain >> " domain
done
# Generate passwords
mysql_db_pwd=$(date +%s | sha256sum | base64 | head -c 32 ; echo)
mysql_root_pwd=$(date +%s | sha256sum | base64 | head -c 32 ; echo)

# Create linked directories
mkdir -p wordpress/$domain/wp-content
cd wordpress/$domain

# Create uploads.ini
cat <<'EOF' > uploads.ini
file_uploads = On
memory_limit = 64M
upload_max_filesize = 64M
post_max_size = 64M
max_execution_time = 600
EOF

# Create docker-compose file
cat <<'EOF' > docker-compose.yml
version: '3.3'

services:
   db:
     image: mysql:5.7
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: @@@mysql_root_pwd@@@
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD: @@@mysql_db_pwd@@@

   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     ports:
       - "@@@hostport@@@:80"
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: @@@mysql_db_pwd@@@
       WORDPRESS_DB_NAME: wordpress
     working_dir: /var/www/html
     volumes:
       - ./wp-content:/var/www/html/wp-content
       - ./uploads.ini:/usr/local/etc/php/conf.d/uploads.ini
volumes:
    db_data: {}
EOF

# replace placeholder values with bash variables
sed -i "s/@@@hostport@@@/${hostport}/g" docker-compose.yml
sed -i "s/@@@mysql_root_pwd@@@/${mysql_root_pwd}/g" docker-compose.yml
sed -i "s/@@@mysql_db_pwd@@@/${mysql_db_pwd}/g" docker-compose.yml

# start docker compose stack
docker-compose up -d
