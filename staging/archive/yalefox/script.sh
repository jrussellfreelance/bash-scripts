echo "🦊 ➜ Hello! Please enter your domain name ONLY; example.com:"

read DOMAIN_NAME 													# Creat

mkdir /usr/local/lsws/conf/vhosts/$DOMAIN_NAME
tee -a /usr/local/lsws/conf/httpd_config.conf <<EOF
virtualhost $DOMAIN_NAME {
  vhRoot                  $DOMAIN_NAME
  configFile              \$SERVER_ROOT/conf/vhosts/$DOMAIN_NAME/vhconf.conf
  allowSymbolLink         1
  enableScript            1
  restrained              0
}
EOF
sed -i "s/Example \*/Example \* \n  map                     $DOMAIN_NAME $DOMAIN_NAME/" /usr/local/lsws/conf/httpd_config.conf

tee /usr/local/lsws/conf/vhosts/$DOMAIN_NAME/vhconf.conf <<EOF
docRoot                   \$VH_ROOT/html
cgroups                   0
EOF
chown lsadm:lsadm -R /usr/local/lsws/conf/vhosts/$DOMAIN_NAME/
systemctl restart lsws



apt install certbot -y

certbot certonly --non-interactive --agree-tos -m $EMAIL --webroot -w /usr/local/lsws/$DOMAIN_NAME/html/ -d $DOMAIN_NAME -d www.$DOMAIN_NAME

tee -a /usr/local/lsws/conf/httpd_config.conf <<EOF
listener https {
  address                 *:443
  secure                  1
  keyFile                 /etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem
  certFile                /etc/letsencrypt/live/$DOMAIN_NAME/cert.pem
  certChain               1
  map                     $DOMAIN_NAME $DOMAIN_NAME
}

EOF

systemctl restart lsws