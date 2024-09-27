#!/bin/bash
# Tested on Ubuntu
# This script installs VSCodium via apt
# refresh apt sources and perform updates
sudo apt update && sudo apt upgrade
# add signing key and repository
curl -fSsL https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/vscodium.gpg > /dev/null
echo deb [signed-by=/usr/share/keyrings/vscodium.gpg] https://download.vscodium.com/debs vscodium main | sudo tee /etc/apt/sources.list.d/vscodium.list
# refresh sources again and install
sudo apt update && sudo apt install codium -y