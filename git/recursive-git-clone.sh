#!/usr/bin/env bash
set -euo pipefail

# Tested on Ubuntu 18.04 LTS and Manjaro 21.01
# This script recursively prompts you for a git URL, cloning the repo into the current directory.
while [ 1 ] ; do
read -p "ENTER GIT URL >> " NAME
git clone $NAME
done
