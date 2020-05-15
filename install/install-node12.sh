#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script installs Node.js 12.
# Download and run Node.js install script
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
# Install nodejs with apt
sudo apt install -y nodejs