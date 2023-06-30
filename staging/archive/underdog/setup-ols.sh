#!/bin/bash

ufw allow 443 																	# open firewall up on 443 for SSL
wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash # Install the repos for OpenLiteSpeed
apt-get install openlitespeed -y												# Install OpenLiteSpeed
apt-get install lsphp73 -y 														# Install PHP for OpenLiteSpeed
ln -sf /usr/local/lsws/lsphp73/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp5 		# Sets up symbolic links for OpenLiteSpeed
/usr/local/lsws/bin/lswsctrl start 												# Start OpenLiteSpeed

sed -i 's/*:8088/*:80/g' /usr/local/lsws/conf/httpd_config.conf 				# Adds the mapping from port 8088 to port 80
systemctl restart lsws 															# Restarts OpenLiteSpeed


OLS_PASSWORD=$(openssl rand -base64 12)
/usr/local/lsws/admin/misc/admpass.sh << EOF
admin
$OLS_PASSWORD
$OLS_PASSWORD
EOF

IP=$(curl -s icanhazip.com)

echo " URL      ➜ http://$IP:7080 "						# Prints link to Admin Panel
echo " username ➜ admin " 								# Prints username
echo " password ➜ $OLS_PASSWORD " 						# Prints password