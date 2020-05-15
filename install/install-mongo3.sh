#!/bin/bash
# Installs Mongo 3.2
# Designed for Ubuntu
# run as sudo
# Add MongoDB apt key and source
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
# Update sources
apt-get update
# Install mongo
apt-get install -y mongodb-org
# Update apt and install MongoDB
apt update
apt install -y mongodb-org
# Set up MongoDB service
echo "Starting and enabling mongod service..."
systemctl start mongod
systemctl status mongod
systemctl enable mongod
