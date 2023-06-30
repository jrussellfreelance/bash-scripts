#!/bin/bash
# This script installs cifs-utils and samba for Ubuntu
# Update apt repositories
apt update
# Install apps
echo "Installing cifs-utils..."
apt install -y cifs-utils
echo "Installing samba..."
apt install -y samba