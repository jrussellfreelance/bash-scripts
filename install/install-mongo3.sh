#!/bin/bash
# Tested on Ubuntu 16.04 LTS
# This script installs MongoDB 3.2.
# Add MongoDB apt key and source
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
# Update sources
sudo apt update
# Install mongo
sudo apt install -y mongodb-org
# Update apt and install MongoDB
sudo apt update
sudo apt install -y mongodb-org
# Set up MongoDB service
echo "Starting and enabling mongod service..."
sudo systemctl start mongod
sudo systemctl status mongod
sudo systemctl enable mongod
