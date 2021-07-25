#!/usr/bin/env bash
set -euo pipefail

# Tested on Ubuntu 18.04
# This script deploys Nextcloud via docker
# Grab variables from user
while [[ -z "$hostport" ]]
do
    read -p "host port >> " hostport
done
while [[ -z "$domain" ]]
do
    read -p "nextcloud domain >> " domain
done
while [[ -z "$mysql_db_pwd" ]]
do
    read -s -p "database user pass >> " mysql_db_pwd
done
while [[ -z "$mysql_root_pwd" ]]
do
    read -s -p "database root pass >> " mysql_root_pwd
done
# Create linked directories
mkdir -p nextcloud/app
cd nextcloud
# Create docker-compose file
cat <<'EOF' > docker-compose.yml
version: '3' 
services:
  db:
    image: mariadb
    container_name: nextcloud-mariadb
    networks:
      - nextcloud_network
    volumes:
      - db:/var/lib/mysql
      - /etc/localtime:/etc/localtime:ro
    environment:
      - MYSQL_ROOT_PASSWORD=@@@mysql_root_pwd@@@
      - MYSQL_PASSWORD=@@@mysql_db_pwd@@@
      - MYSQL_DATABASE=nextcloud
      - MYSQL_USER=nextcloud
    restart: unless-stopped
  
  app:
    image: nextcloud:latest
    container_name: nextcloud-app
    networks:
      - nextcloud_network
    ports:
      - @@@hostport@@@:80
    depends_on:
      - db
    volumes:
      - nextcloud:/var/www/html
      - ./app/config:/var/www/html/config
      - ./app/custom_apps:/var/www/html/custom_apps
      - ./app/data:/var/www/html/data
      - ./app/themes:/var/www/html/themes
      - /etc/localtime:/etc/localtime:ro
    environment:
      - VIRTUAL_HOST=@@@domain@@@
    restart: unless-stopped
volumes:
  nextcloud:
  db:
networks:
  nextcloud_network:
EOF

# replace placeholder values with bash variables
sed -i "s/@@@hostport@@@/${hostport}/g" docker-compose.yml
sed -i "s/@@@domain@@@/${domain}/g" docker-compose.yml
sed -i "s/@@@mysql_root_pwd@@@/${mysql_root_pwd}/g" docker-compose.yml
sed -i "s/@@@mysql_db_pwd@@@/${mysql_db_pwd}/g" docker-compose.yml

# start docker compose stack
docker-compose up -d
# docker exec nextcloud-app sed -i "s/http\:\/\/\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}\:${hostport}/https\:\/\/${domain}/g" config/config.php
# docker exec nextcloud-app sed -i "s/\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}\:${hostport}/${domain}/g" config/config.php
