#!/bin/bash
# This script iterates over every folder in a root folder and runs git pull in each folder.
while [[ -z "$ROOT" ]]
do
    read -p "Root directory for recursive git pull: " ROOT
done
cd $ROOT
for d in */ ; do
    cd "$d"
    git pull
    cd ..
done 