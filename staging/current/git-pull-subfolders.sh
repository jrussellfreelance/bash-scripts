#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script iterates over every subfolder in the current directory and runs git pull in each folder.
for d in $(pwd) ; do
    cd "$d"
    git pull
    cd ..
done 