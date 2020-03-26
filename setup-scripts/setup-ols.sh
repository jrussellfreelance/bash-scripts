#!/bin/bash
### LSWS
# One click install script
wget --no-check-certificate https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh
bash ols1clk.sh

# Port Mapping
sed -i 's/*:8088/*:80/g' /usr/local/lsws/conf/httpd_config.conf         # Adds the mapping from port 8088 to port 80

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