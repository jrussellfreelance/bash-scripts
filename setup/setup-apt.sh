#!/bin/bash
# Designed for Ubuntu
# Update the apt cache
sudo apt update
# Perform updates
sudo apt -y upgrade
sudo apt -y dist-upgrade
# Remove uneeded packages
sudo apt -y autoremove