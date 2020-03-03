#!/bin/bash
# Designed on Ubuntu 18.04 32-bit for a raspberrypi
# run as sudo
# Grab mountpoint, mount PTH and mount USR
echo " >> printing available drives for you << "
fdisk -l
while [[ -z "$MOUNT" ]]
do
read -p "enter mount point >> " MOUNT
done
while [[ -z "$PTH" ]]
do
read -p "enter mount PTH  >> " PTH
done
while [[ -z "$USR" ]]
do
read -p "enter mount USR  >> " USR
done
mkdir -p $PTH
# Mount point
mount -t ext4 $MOUNT $PTH
# Add USR
USRadd -d $PTH -g sudo $USR
# Install samba
apt update
apt -y install samba
# Set password for new USR, it will prompt you
smbpasswd -a $USR
echo "[mount]
PTH = $PTH
valid USRs = $USR
read only = no
" >> /etc/samba/smb.conf
# Restart smb service
systemctl restart smbd
# Add to fstab
echo "$MOUNT           $PTH    ext4       rw,defaults         0      0" >> /etc/fstab