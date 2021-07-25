#!/usr/bin/env bash
set -euo pipefail

# Designed for Ubuntu 18.04
# This script installs Nginx, Certbot, MySQL, and php-fpm onto your server.
echo "A LEMP web server set up script"
echo "Installing Nginx..."
sudo apt update
sudo apt install -y nginx
echo "Allowing Nginx through ufw firewall"
sudo ufw allow "Nginx Full"
echo "Installing certbot and Let's Encrypt..."
sudo add-apt-repository ppa:certbot/certbot
sudo apt update
sudo apt install -y python-certbot-nginx
echo "Restarting Nginx..."
sudo systemctl restart nginx
echo "Installing MySQL..."
sudo apt install -y mysql-server
echo "Running MySQL secure installation script..."
sudo mysql_secure_installation
echo "Installing PHP-FPM..."
sudo apt install -y php-fpm php-mysql
echo "Disabling CGI Fix Path Info"
sudo sed -i 's/;*cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/fpm/php.ini
echo "Restarting PHP-FPM..."
sudo systemctl restart php7.2-fpm
echo "Now you need to configure your Nginx config files to use PHP-FPM.  Other than that, all done!"
