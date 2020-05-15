#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script downloads homebrew and adds it to your PATH.
# It also installs gcc through brew as well as the patchelf apt package.
# Download and run install script
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
# Add brew to your bash profile and update
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.bash_profile
source ~/.bash_profile
# Install gcc, attempting to install patchelf through apt first as a dependency
sudo apt update
sudo apt install patchelf -y
brew install gcc