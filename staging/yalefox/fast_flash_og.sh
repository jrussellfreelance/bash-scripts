#!/bin/bash
# Make sure you have homebrew, wget and balena-cli installed.

tput setaf 1; echo 🦊 "Making sure that we have the latest version of Raspbian"
wget --continue --output-document=raspian_latest.zip https://downloads.raspberrypi.org/raspbian_latest

# 	This creates a variable called three_shas, and then 
#	downloads some information off this website with cURL https://www.raspberrypi.org/downloads/raspbian/

# 	It will return this

# 	<div class="image-details sha256"><span>SHA-256:</span> <strong>549da0fa9ed52a8d7c2d66cb06afac9fe856638b06d8f23df4e6b72e67ed4cea</strong></div>
# 	<div class="image-details sha256"><span>SHA-256:</span> <strong>2c4067d59acf891b7aa1683cb1918da78d76d2552c02749148d175fa7f766842</strong></div>
# 	<div class="image-details sha256"><span>SHA-256:</span> <strong>a50237c2f718bd8d806b96df5b9d2174ce8b789eda1f03434ed2213bbca6c6ff</strong></div>

# 	First head:: 	Raspbian Buster with desktop and recommended software
# 	Second head: 	Raspbian Buster with desktop
# 	Third head:	Raspbian Buster Lite

# 	SHA-256 is 256 bytes long, which is 64 characters { 2 ^ 64 } 
# 	So we want to take the string of terminal Str(73, 73+64)

# 	When we cut it, it returns this:
# 		549da0fa9ed52a8d7c2d66cb06afac9fe856638b06d8f23df4e6b72e67ed4cea
# 		2c4067d59acf891b7aa1683cb1918da78d76d2552c02749148d175fa7f766842
# 		a50237c2f718bd8d806b96df5b9d2174ce8b789eda1f03434ed2213bbca6c6ff


three_shas=$(curl --silent https://www.raspberrypi.org/downloads/raspbian/ | grep 'SHA-256' | cut -c73-136)

remote_buster_all=$(echo $three_shas | head -1 | tail -2)			# Raspbian Buster with desktop and recommended software
remote_buster_desktop=$(echo $three_shas | head -2 | tail -1)		# Raspbian Buster with desktop
remote_buster_lite=$(echo $three_shas | tail -1)					# Raspbian Buster Lite

remote_sha=$(echo $remote_buster_desktop)							# Where you pick the version you want.

# Calculate the SHA-256 Checksum downloaded from the same file. The output looks like 
# 2c4067d59acf891b7aa1683cb1918da78d76d2552c02749148d175fa7f766842  raspian_latest.zip
# So we cut the first 64 characters

local_sha="$(shasum -a 256 raspian_latest.zip | cut -c1-64)"



# If they are the same, print that they are. If they are not, delete the file, and re-download it.
# Both variables need to be converted to strings, so "put them in quotes" and then  check
if [[ $remote_sha==$local_sha ]]; then
    tput setaf 5; echo 🦊 "The local version of the file is intact."
else
    tput setaf 5; echo 🦊 "Bad local version of the file. I'm deleting it."
    sudo rm -rf raspian_latest.zip
    exit
fi

# Burn the latest downloaded image to the SD card.
sudo balena local flash raspian_latest.zip --drive /dev/disk2 --yes
tput setaf 5; echo 🦊 "SD Card flashed and verified succesfully."

# Create a blank SSH file to enable it.
sudo touch /Volumes/boot/ssh
tput setaf 5; echo 🦊 "SSH enabled"

# This will write the wpa_supplicant file to your Raspberry Pi
# Update your SSID and PSK 
echo "country=US
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
    ssid="_fios-sucks"
    psk="dynamicmango925"
}" > /Volumes/boot/wpa_supplicant
tput setaf 1; echo 🦊 "WiFi Settings Copied to SD Card"

# Unmount the drive
diskutil eject /dev/disk2
tput setaf 1; echo 🦊 "disk unmounted"

# Notify the user 
osascript -e 'tell app "System Events" to display dialog "Pi is written!"'
