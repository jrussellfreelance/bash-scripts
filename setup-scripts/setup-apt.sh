#!/bin/bash
# Designed for Ubuntu
# Update the apt cache
apt update
# Perform updates
apt -y upgrade
apt -y dist-upgrade
# Remove uneeded packages
apt -y autoremove