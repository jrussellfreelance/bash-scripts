#!/bin/bash

# Assign Color Variables
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7
# Configuring ufw rules and enabling ufw service
tput setaf $MAGENTA; echo ">> Checking the status of ufw..."
if ufw status | head -1 | grep -q "inactive" ; then
  tput setaf $CYAN; echo "Adding some ufw rules and enabling the ufw service..."
  tput setaf $YELLOW;
  sudo ufw allow 'Nginx Full'
  sudo ufw allow OpenSSH
  sudo ufw enable <<EOF
y
EOF
else
  tput setaf $GREEN; echo "ufw is already enabled!"
fi