#!/bin/bash
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
add-apt-repository 'deb https://typora.io/linux ./'
apt update
apt install -y typora