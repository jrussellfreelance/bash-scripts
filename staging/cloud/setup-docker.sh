#!/bin/bash
# Tested on Ubuntu 18.04 32-bit for a Raspberry Pi
# This script installs docker on a Raspberry Pi.
# download and run docker install script
curl -sSL https://get.docker.com | sudo sh
# add ubuntu user to docker
sudo usermod -aG docker ubuntu