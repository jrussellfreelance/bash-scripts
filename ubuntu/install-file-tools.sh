#!/bin/bash
# This script installs cifs-utils and samba for Ubuntu
# Update apt repositories
apt update
# Install apps
apt update
echo "Installing cifs-utils..."
apt --assume-yes install cifs-utils
echo "Installing samba..."
apt --assume-yes install samba