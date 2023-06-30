#!/bin/bash
# This script installs Ajenti 1 onto your server
echo "An Ajenti installation script"
echo "Installing Ajenti..."
wget http://repo.ajenti.org/debian/key -O- | apt-key add -
echo "deb http://repo.ajenti.org/ng/debian main main ubuntu" | tee -a /etc/apt/sources.list
apt-get update
apt-get install ajenti
echo "Starting Ajenti..."
service ajenti restart
echo "Installing Ajenti plugins..."
apt-get install ajenti-v ajenti-v-nginx ajenti-v-mysql ajenti-v-php-fpm ajenti-v-mail ajenti-v-nodejs php5-mysql
echo "Restarting Ajenti..."
service ajenti restart
myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
echo "Now browse to https://${myip}:8000/ and login with the following credentials:"
echo "Username: root"
echo "Password: admin"
echo "All done!"