#!/bin/bash

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
echo " OLS User  ➜ admin"
echo " OLS Pass  ➜ $OLS_PASSWORD"
echo " OLS URL   ➜ http://$IP:7080"
echo " WP  URL   ➜ http://$IP"