#!/bin/bash
# Tested on Ubuntu
# This script installs some common dependencies

# print package names
cat <<'EOF'
! installing via apt:
- apt-transport-https
- build-essential
- ca-certificates
- curl
- dirmngr
- expect
- git
- nano
- net-tools
- plocate
- software-properties-common
- uidmap
- unzip
- vim
- wget
EOF

# perform update & install & autoremove
sudo apt update && sudo apt install -y \
apt-transport-https \
build-essential \
ca-certificates \
curl \
dirmngr \
expect \
git \
nano \
net-tools \
plocate \
software-properties-common \
uidmap \
unzip \
vim \
wget &&
sudo apt autoremove -y