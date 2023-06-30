#!/bin/bash
# Designed for Ubuntu
##############################
#     tput setaf colors      #
# tput setaf 0 > black       #
# tput setaf 1 > red         #
# tput setaf 2 > green       #
# tput setaf 3 > yellow      #
# tput setaf 4 > blue        #
# tput setaf 5 > magenta     #
# tput setaf 6 > cyan        #
# tput setaf 7 > white       #
##############################
# Assign Color Variables
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7
# Download and run install script
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
# Add brew to your bash profile and update
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.bash_profile
source ~/.bash_profile
# Install gcc, attempting to install patchelf through apt first as a dependency
sudo apt update
sudo apt install patchelf -y
brew install gcc
brew install balena-cli
tput setaf $MAGENTA; echo "   >> Listing All Drives <<   "
sudo fdisk -l | grep /dev/
while [ -z "$PTH" ]; do
tput setaf $CYAN; read -p "   >> Enter the full path of disk >> " PTH