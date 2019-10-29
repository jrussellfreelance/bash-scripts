#!/bin/bash
# Designed for Ubuntu 18.04
echo "An Nginx redirect config file generator"
while [[ -z "$WEBURL" ]]
do
    read -p "Redirect TO this website URL (FQDN): " WEBURL
done
while [[ -z "$WEBNAME" ]]
do
    read -p "Redirect FROM this website URL (FQDN):" WEBNAME
done
cp ../templates/nginx/redirect /etc/nginx/sites-available/$WEBNAME
ln -s /etc/nginx/sites-available/$WEBNAME /etc/nginx/sites-enabled/$WEBNAME
sed -i 's/sub.domain.ext/'$WEBNAME'/g' /etc/nginx/sites-enabled/$WEBNAME
sed -i 's/domain.ext/'$WEBURL'/g' /etc/nginx/sites-enabled/$WEBNAME
systemctl restart nginx
certbot --nginx -d $WEBNAME
