#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script recursively prompts you for a git URL, cloning the repo into the current directory.
while [ 1 ] ; do
read -p "ENTER GIT URL >> " NAME
git clone $NAME
done