#!/bin/bash
cd ~/openmappr
nvm use 8.12.0
npm install -g yo bower grunt-cli
npm install --unsafe-perm=true --allow-root
bower install --allow-root
grunt
sudo docker-compose -f docker-compose-local.yml up -d