#!/bin/bash
# This script installs PowerShell Core for Ubuntu 18.04
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
dpkg -i packages-microsoft-prod.deb

# Update the list of products
apt update

# Enable the "universe" repositories
add-apt-repository universe

# Install PowerShell
apt install -y powershell

# Delete deb file
rm -f packages-microsoft-prod.deb
echo "All done! =D"