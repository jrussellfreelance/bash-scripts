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
mkdir -p $PTH
# Mount point
mount -t ext4 $MOUNT $PTH
# Add USR
useradd -d $PTH -g sudo $USR
# Install samba
apt update
apt -y install samba
# Set password for new user, it will prompt you
smbpasswd -a $USR
echo "[$NAM]
path = $PTH
valid users = $USR
read only = no
" >> /etc/samba/smb.conf
# Restart smb service
systemctl restart smbd
# Add to fstab
echo "$MOUNT           $PTH    ext4       rw,defaults         0      0" >> /etc/fstab