#!/bin/bash
# Designed on Ubuntu 18.04 32-bit
# run as sudo
# Grab mountpoint and smb password, retrieve using fdisk -l or df -h
while [[ -z "$MOUNT" ]]
do
read -p "enter mount  >> " MOUNT
done
while [[ -z "$PASSWORD" ]]
do
read -p "smb password >> " PASSWORD
done
mkdir -p /media/mount
# Mount point
mount -t ext4 $MOUNT /media/mount
# Add mount user
useradd -d /media/mount -g sudo mount
# Install samba
apt update
apt -y install samba
# Set password for mount user
smbpasswd -a mount
echo "[mount]
path = /media/mount
valid users = mount
read only = no
" >> /etc/samba/smb.conf
# Restart smb service
systemctl restart smbd