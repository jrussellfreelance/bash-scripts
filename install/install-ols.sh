#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script installs and configures OpenLiteSpeed.
# One click install script
wget --no-check-certificate https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh
bash ols1clk.sh
rm -f ols1clk.sh

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

echo " Admin URL ➜ http://$IP:7080 "          # Prints link to Admin Panel
echo " OLS User  ➜ admin "                # Prints username
echo " Password  ➜ $OLS_PASSWORD "            # Prints password
