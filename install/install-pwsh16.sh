#!/usr/bin/env bash
set -euo pipefail

# Tested on Ubuntu 16.04 LTS
# This script installs Powershell Core on Ubuntu 16.04.
wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo rm -f packages-microsoft-prod.deb
sudo apt update
sudo apt install -y powershell
