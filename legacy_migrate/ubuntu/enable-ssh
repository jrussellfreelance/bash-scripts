#!/bin/bash
# This script installs and enables openssh-server for Ubuntu.
# Update apt repositories
apt update
# Install OpenSSH server
echo "Installing OpenSSH server..."
apt install openssh-server
# Allow through firewall
echo "Allowing OpenSSH through ufw firewall"
ufw allow "OpenSSH"
echo "All done! =D"