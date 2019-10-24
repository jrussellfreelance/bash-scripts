#!/bin/bash
# Designed for Ubuntu
# This script creates a new sudo user
while [[ -z "$NAME" ]]
do
    read -p "User Name: " NAME
done
while [[ -z "$PASSWORD" ]]
do
    read -s -p "User Password: " PASSWORD
done
while [[ -z "$PASSWORD2" ]]
do
    read -s -p "User Password Again: " PASSWORD2
done
echo "Creating user..."
useradd -s /bin/bash -d /home/$NAME/ -m -G sudo $NAME
echo "Setting password..."
passwd $NAME <<EOF
$PASSWORD
$PASSWORD2
EOF