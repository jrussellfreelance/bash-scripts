#!/bin/bash
# Tested on Ubuntu 18.04
# This script deploys Nextcloud via docker
while [[ -z "$hostport" ]]
do
    read -p "host port >> " hostport
done
mkdir -p nextcloud/{apps,config,data}
cd nextcloud
docker run  --name nextcloud -d \
-p $hostport:80 \
-v $(pwd):/var/www/html \
-v apps:/var/www/html/custom_apps \
-v config:/var/www/html/config \
-v data:/var/www/html/data \
nextcloud