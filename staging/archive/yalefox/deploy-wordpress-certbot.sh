#!/bin/bash
# This script performs set up tasks for an Underdog server

### Apt Setup
echo "Let's get started! Starting with some apt configuration..."
apt update
apt -y upgrade
apt -y dist-upgrade
apt -y autoremove
### Create sudo user
echo "Creating a sudo user for you to use..."
NAME="wwwadmin"
USER_PASSWORD=$(openssl rand -base64 12)
useradd -s /bin/bash -d /home/$NAME/ -m -G sudo $NAME
passwd $NAME <<EOF > /dev/null
$USER_PASSWORD
$USER_PASSWORD
EOF
# When you log in, run "su wwwadmin" to become the correct user

### Certbot
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install certbot -y
sudo apt-get install python3-certbot-dns-cloudflare -y

mkdir -p ~/.secrets/certbot/

echo "🦊 ➜ Please enter your Cloudflare email exactly:"
read CF_EMAIL

echo "🦊 ➜ Please paste your Cloudflare global API key:"
read CF_GLOBAL

cat <<EOF>> ~/.secrets/certbot/cloudflare.ini
# Cloudflare API credentials used by Certbot
dns_cloudflare_email = $CF_EMAIL
dns_cloudflare_api_key = $CF_GLOBAL
EOF
chmod 600 ~/.secrets/certbot/cloudflare.ini
echo "🦊 ➜ Please enter your domain or subdomain:"
read DOMAIN_NAME
certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini \
  -d $DOMAIN_NAME

# LSWS one click install with Wordpress
wget --no-check-certificate https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh; bash ols1clk.sh -w;

# Port Mapping
sed -i 's/*:8088/*:80/g' /usr/local/lsws/conf/httpd_config.conf         # Adds the mapping from port 8088 to port 80

# Update wordpress config
echo "
docRoot                   \$VH_ROOT
vhDomain                  $DOMAIN_NAME
cgroups                   0

index  {
  useServer               1
  indexFiles              index.php
}

scripthandler  {
  add                     lsapi:lsphp php
}

context / {
  location                /usr/local/lsws/wordpress
  allowBrowse             1
  indexFiles              index.php

  rewrite  {
    enable                1
    inherit               1
rewriteFile             /usr/local/lsws/wordpress/.htaccess
  }
  addDefaultCharset       off

  phpIniOverride  {

  }
}

rewrite  {
  enable                  1
  autoLoadHtaccess        1
}

vhssl  {
  keyFile                 /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem
  certFile                /etc/letsencrypt/live/$DOMAIN_NAME/cert.pem
  certChain               1
  CACertFile              /etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem
}
" > /usr/local/lsws/conf/vhosts/wordpress/vhconf.conf


# OLS Admin Password
OLS_PASSWORD=$(openssl rand -base64 12)
/usr/local/lsws/admin/misc/admpass.sh << EOF
admin
$OLS_PASSWORD
$OLS_PASSWORD
EOF

# Restart OpenLiteSpeed
systemctl restart lsws

# Get IP Address
IP=$(curl -s icanhazip.com)

# Print information
echo " Username  ➜ $NAME"
echo " Password  ➜ $USER_PASSWORD"
echo " Admin URL ➜ http://$IP:7080 "          # Prints link to Admin Panel
echo " OLS User  ➜ admin "                # Prints username
echo " Password  ➜ $OLS_PASSWORD "            # Prints password