#!/bin/bash
# This script iterates over every folder in a root folder and starts a PM2 process for each app.
# I use it on my demo server, to periodically start all my demo apps in case somebody broke any demos
while [[ -z "$ROOT" ]]
do
    read -p "Root directory for recursive pm2 start: " ROOT
done
cd $ROOT
for d in */ ; do
    cd "$d"
    dir=${d%?}
    pm2 start server.js --name "$dir"
    cd ..
done