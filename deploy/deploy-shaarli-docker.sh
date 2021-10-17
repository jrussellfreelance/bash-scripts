#!/usr/bin/env bash
set -euo pipefail

# Tested on Ubuntu 18.04
# This script deploys Shaarli via docker
while [[ -z "$hostport" ]]
do
    read -p "host port >> " hostport
done
mkdir -p shaarli/{cache,data}
cd shaarli
docker volume create shaarli-data
docker volume create shaarli-cache
docker create \
    --name shaarli \
    -v cache:/var/www/shaarli/cache \
    -v data:/var/www/shaarli/data \
    -p $hostport:80 \
    shaarli/shaarli:master
docker start shaarli
docker exec -ti shaarli chown -R nginx:nginx /var/www/shaarli/data
