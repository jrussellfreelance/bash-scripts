#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script updates the apt cache, performs upgrades, and removes unneeded packages.
# Update the apt cache
sudo apt update
# Perform updates
sudo apt -y upgrade
sudo apt -y dist-upgrade
# Remove uneeded packages
sudo apt -y autoremove