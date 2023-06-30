#!/bin/bash
echo "Installing Paper icon theme..."
sudo add-apt-repository -u ppa:snwh/ppa
sudo apt install -y paper-icon-theme
echo "Installing Insomnia REST Client..."
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y insomnia
