#!/bin/bash
# Tested on Ubuntu 20.04 LTS
# This script updates the apt cache, performs upgrades, and removes unneeded packages.
# Update the apt cache
sudo apt-get update
# Perform updates
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
# Remove uneeded packages
sudo apt-get -y autoremove
