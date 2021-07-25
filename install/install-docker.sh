#!/usr/bin/env bash
set -euo pipefail

# Tested on Ubuntu 18.04 LTS
# This script installs docker and docker-compose.
# install docker using script
curl -sSL https://get.docker.com | sudo bash
# download and install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# enable and start docker
sudo systemctl start docker && sudo systemctl enable docker
# add current user to docker group
sudo usermod -aG docker $(whoami)
