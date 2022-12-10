#!/bin/bash
# Tested on Ubuntu 22.04
# This script creates an nginx reverse proxy
### Assign Color Variables
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7

# var init
# domain=''
# proxypass=''

tput setaf $CYAN;
while [[ -z "$domain" ]]
do
    read -p "domain >> " domain
done
while [[ -z "$proxypass" ]]
do
    read -p "full proxy_pass (e.g. http://127.0.0.1:8082) >> " proxypass
done
tput setaf $YELLOW;
cd /etc/nginx/sites-available/
touch $domain
echo "
server {
    listen 80;
    listen [::]:80;
    server_name ${domain};
    client_max_body_size 2048M;
    location / {
        proxy_pass ${proxypass};
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
" > $domain
ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/
nginx -t
# certbot --nginx -d $domain
systemctl reload nginx

tput setaf $MAGENTA;
echo ">> Config file: /etc/nginx/sites-available/$domain <<"
echo ">> https://$domain <<"
tput setaf $WHITE;
