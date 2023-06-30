#!/bin/bash
# Designed for Ubuntu
# script - A script that creates a new sudo user with the name admin
# Assign Color Variables
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7
tput setaf $CYAN;
NAME="wwwadmin"
PASSWORD=$(openssl rand -base64 12)
useradd -s /bin/bash -d /home/$NAME/ -m -G sudo $NAME
passwd $NAME <<EOF > /dev/null
$PASSWORD
$PASSWORD
EOF
tput setaf $MAGENTA;
echo "User:     $NAME"
echo "Password: $PASSWORD"
tput setaf $WHITE;
su wwwadmin