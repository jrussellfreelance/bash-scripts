#!/bin/bash
# Designed for Ubuntu 18.04
# This script installs Powershell Core on Ubuntu 18.04.
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo rm -f packages-microsoft-prod.deb
sudo apt update
sudo apt install -y powershell