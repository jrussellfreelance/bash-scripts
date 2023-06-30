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

# LSWS one click install with Wordpress
wget --no-check-certificate https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh
bash ols1clk.sh -w


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
echo " Sys User  ➜ $NAME"
echo " Sys Pass  ➜ $USER_PASSWORD"
echo " OLS User  ➜ admin"
echo " OLS Pass  ➜ $OLS_PASSWORD"
echo " OLS URL   ➜ http://$IP:7080"
echo " WP  URL   ➜ http://$IP"