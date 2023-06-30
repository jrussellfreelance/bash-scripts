#!/bin/bash
sudo apt update -y										# Update system repositories
sudo apt-get remove docker docker-engine docker.io -y 	# Remove any old versions of docker
sudo apt install docker.io -y 							# Install docker
sudo systemctl start docker 							# Start Docker
sudo systemctl enable docker 							# Enable Docker on boot
docker --version 										# Check version of docker (to see if it installed)