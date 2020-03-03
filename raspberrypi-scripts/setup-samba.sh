#!/bin/bash
# Designed on Ubuntu 18.04 32-bit for a raspberrypi
# run as sudo
# Grab mountpoint, mount path and mount user
echo " >> printing available drives for you << "
fdisk -l
while [[ -z "$MOUNT" ]]
do
read -p "enter mount point >> " MOUNT
done
while [[ -z "$PATH" ]]
do
read -p "enter mount path  >> " PATH
done
while [[ -z "$USER" ]]
do
read -p "enter mount user  >> " USER
done
mkdir -p $PATH
# Mount point
mount -t ext4 $MOUNT $PATH
# Add user
useradd -d $PATH -g sudo $USER
# Install samba
apt update
apt -y install samba
# Set password for new user, it will prompt you
smbpasswd -a $USER
echo "[mount]
path = $PATH
valid users = $USER
read only = no
" >> /etc/samba/smb.conf
# Restart smb service
systemctl restart smbd
# Add to fstab
echo "$MOUNT           $PATH    ext4       rw,defaults         0      0" >> /etc/fstab