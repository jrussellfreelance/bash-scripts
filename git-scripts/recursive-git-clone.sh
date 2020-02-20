#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script endlessly prompts for a git URL and clones it into the current directory
while [ 1 ] ; do
read -p "ENTER GIT URL >> " NAME
git clone $NAME
done