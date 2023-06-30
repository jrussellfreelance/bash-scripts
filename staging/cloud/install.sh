#!/bin/bash
echo "Installing git..."
sudo apt install -y git
echo "Installing Arc theme..."
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/home:Horst3180.list"
wget -nv https://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update
sudo apt-get install -y arc-theme
echo "Installing Paper icon theme..."
sudo add-apt-repository -u ppa:snwh/ppa
sudo apt install -y paper-icon-theme
echo "Installing Insomnia REST Client..."
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y insomnia
