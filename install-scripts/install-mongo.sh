#!/bin/bash
# Designed for Ubuntu
# run as sudo
# Add MongoDB apt key and source
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
# Update apt and install MongoDB
apt update
apt install -y mongodb-org
# Set up MongoDB service
echo "Starting and enabling mongod service..."
systemctl start mongod
systemctl status mongod
systemctl enable mongod