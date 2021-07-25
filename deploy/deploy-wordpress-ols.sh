#!/usr/bin/env bash
set -euo pipefail

# This script installs Wordpress and OLS for a selfhosted server

# Assign Color Variables
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7

tput setaf $CYAN; read -n1 -p "Press Y/y to set up Wordpress with OpenLiteSpeed on this server >> "  key

if [[ "$key" != "y" && "$key" != "Y" ]] ; then
  tput setaf $RED; echo ">> Exiting! "
  tput setaf $WHITE;
	exit
fi

# Call sudo to have user enter their password
tput setaf $MAGENTA; echo "
>> Asking for a sudo password..."
sudo whoami >>/dev/null

# Grab wordpress domain
tput setaf $CYAN;
while [[ -z "$domain" ]]
do
    read -p ">> WordPress domain >> " domain
done

# Perform apt upgrades
tput setaf $MAGENTA; echo ">> Running apt upgrades..."
tput setaf $YELLOW;
sudo apt update
sudo apt -y upgrade
sudo apt -y autoremove


# LSWS one click install with Wordpress
tput setaf $MAGENTA; echo ">> Running OpenLiteSpeed/WordPress install script..."
tput setaf $YELLOW;
wget --no-check-certificate https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh
bash ols1clk.sh -w
rm -rf ols1clk.sh

# Set OLS admin password
tput setaf $MAGENTA; echo ">> Setting OpenLiteSpeed admin password..."
tput setaf $YELLOW;
OLS_PASSWORD=$(openssl rand -base64 12)
/usr/local/lsws/admin/misc/admpass.sh << EOF
admin
$OLS_PASSWORD
$OLS_PASSWORD
EOF

# Set wordpress virtualhost settings
tput setaf $MAGENTA; echo ">> Creating WordPress virtual host configuration..."
tput setaf $YELLOW;
echo "
docRoot                   \$VH_ROOT/

index  {
  useServer               0
  indexFiles              index.php
}

scripthandler  {
  add                     lsapi:lsphp php
}

context / {
  type                    NULL
  location                \$VH_ROOT
  allowBrowse             1
  indexFiles              index.php

  rewrite  {
    enable                1
    inherit               1
rewriteFile           /usr/local/lsws/wordpress/.htaccess
  }
}
" > /usr/local/lsws/conf/vhosts/wordpress/vhconf.conf

# Set wordpress htaccess values
tput setaf $MAGENTA; echo ">> Updating Wordpress htaccess file..."
tput setaf $YELLOW;
echo "
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteRule ^(.*)$ https://$domain/\$1 [R,L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{SERVER_PORT} 80
# BEGIN NON_LSCACHE
## LITESPEED WP CACHE PLUGIN - Do not edit the contents of this block! ##
## LITESPEED WP CACHE PLUGIN - Do not edit the contents of this block! ##
# END NON_LSCACHE
" > /usr/local/lsws/wordpress/.htaccess
chmod 755 /usr/local/lsws/wordpress/.htaccess

# Set default OpenLiteSpeed upload settings
tput setaf $MAGENTA; echo ">> Replacing OLS upload settings..."
tput setaf $YELLOW;
# Change upload max filesize from 2 MB to 64 MB
sed -i '/upload_max_filesize/s/= 2M/=64M/' /usr/local/lsws/lsphp73/etc/php/7.3/litespeed/php.ini
# Add post max size limit to end of config
echo ';; Custom Settings ;;' >> /usr/local/lsws/lsphp73/etc/php/7.3/litespeed/php.ini
echo 'post_max_size = 64M' >> /usr/local/lsws/lsphp73/etc/php/7.3/litespeed/php.ini

# Get IP Address
IP=$(curl -s icanhazip.com)

# Print information
tput setaf $CYAN;
echo ">> Login Details"
echo ">> OLS User  >> admin"
echo ">> OLS Pass  >> $OLS_PASSWORD"
echo ">> OLS URL   >> https://$IP:7080"
echo ">> WP  URL   >> https://$domain"

# Set default color back to white
tput setaf $WHITE;
