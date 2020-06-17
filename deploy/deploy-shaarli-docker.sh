#!/bin/bash
# Designed for Ubuntu 18.04
# This script deploys Shaarli through docker
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