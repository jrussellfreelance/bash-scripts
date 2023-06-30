#!/bin/bash
tput setaf 5; echo 🦊 Downloading SD Cloner
# Download SD Clone
wget -P /Users/yale/Desktop/first-install-downloads/ https://twocanoes-software-updates.s3.amazonaws.com/SDClone3.dmg # SD Cloner
# Mount dmg
hdiutil attach /Users/yale/Desktop/first-install-downloads/SDClone3.dmg
# Change to mount directory
cd "/Volumes/SD Clone"
# Install package
sudo installer -pkg "SD Clone.pkg" -target "/"
# Unmount dmg
sleep 5
hdiutil detach "/Volumes/SD Clone"