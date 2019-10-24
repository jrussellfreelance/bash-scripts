#!/bin/bash
echo "A Node.js v10 web server set up script"
echo "Installing Nginx..."
apt-get update
apt-get --assume-yes install nginx
echo "Allowing Nginx through ufw firewall"
ufw allow "Nginx Full"
echo "Installing certbot and Let's Encrypt..."
add-apt-repository ppa:certbot/certbot
apt-get update
apt-get --assume-yes install python-certbot-nginx
echo "Restarting Nginx..."
systemctl restart nginx
echo "Installing Node.js..."
cd /tmp
curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
bash nodesource_setup.sh
apt-get --assume-yes install nodejs
apt-get --assume-yes install build-essential
echo "Installing pm2 module..."
npm install -g pm2
echo "All done!"