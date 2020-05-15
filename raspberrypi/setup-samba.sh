#!/bin/bash
# Tested on Ubuntu 18.04 32-bit for a Raspberry Pi
# This script guides you through setting up a samba share.
### Assign Color Variables
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7

# Grab mountpoint, mount path and mount user
tput setaf $CYAN; echo " >> printing available drives for you << "
fdisk -l
tput setaf $MAGENTA;
while [[ -z "$MOUNT" ]]
do
read -p "enter mount point >> " MOUNT
done
while [[ -z "$PTH" ]]
do
read -p "enter mount path  >> " PTH
done
while [[ -z "$USR" ]]
do
read -p "enter mount user  >> " USR
done
while [[ -z "$NAM" ]]
do
read -p "enter mount name  >> " NAM
done
tput setaf $CYAN; 
sudo mkdir -p $PTH
# Mount point
sudo mount -t ext4 $MOUNT $PTH
# Add USR
sudo useradd -d $PTH -g sudo $USR
# Install samba
sudo apt update
sudo apt -y install samba
# Set password for new user, it will prompt you
sudo smbpasswd -a $USR
echo "[$NAM]
path = $PTH
valid users = $USR
read only = no
" >> /etc/samba/smb.conf
# Restart smb service
sudo systemctl restart smbd
# Add to fstab
sudo echo "$MOUNT           $PTH    ext4       rw,defaults         0      0" >> /etc/fstab
tput setaf $WHITE;