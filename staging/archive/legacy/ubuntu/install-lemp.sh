#!/bin/bash
# Designed for Ubuntu 18.04
# This script installs nginx, certbot, mysql, and php-fpm onto your server 
echo "A LEMP web server set up script"
echo "Installing Nginx..."
apt-get update
apt install -y nginx
echo "Allowing Nginx through ufw firewall"
ufw allow "Nginx Full"
echo "Installing certbot and Let's Encrypt..."
add-apt-repository ppa:certbot/certbot
apt-get update
apt install -y python-certbot-nginx
echo "Restarting Nginx..."
systemctl restart nginx
echo "Installing MySQL..."
apt install -y mysql-server
echo "Running MySQL secure installation script..."
mysql_secure_installation
echo "Installing PHP-FPM..."
apt install -y php-fpm php-mysql
echo "Disabling CGI Fix Path Info"
sed -i 's/;*cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/fpm/php.ini
echo "Restarting PHP-FPM..."
systemctl restart php7.2-fpm
echo "Now you need to configure your Nginx config files to use PHP-FPM.  Other than that, all done!"