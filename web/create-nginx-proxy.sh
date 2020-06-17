#!/bin/bash
while [[ -z "$domain" ]]
do
    read -p "domain >> " domain
done
while [[ -z "$appport" ]]
do
    read -p "port   >>" appport
done
sudo apt install letsencrypt -y
certbot certonly --rsa-key-size 2048 --standalone --agree-tos --no-eff-email --email jesse@jrussell.io -d ${domain}
sudo apt install nginx -y
cd /etc/nginx/sites-available/
touch $domain
echo "
server {
       listen 80;
       server_name ${domain};
       return 301 https://"'$server_name$request_uri'";
}
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name ${domain};
    ssl_certificate /etc/letsencrypt/live/${domain}/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/${domain}/privkey.pem;
    location / {
      proxy_pass http://127.0.0.1:${appport};
      proxy_set_header X-Forwarded-For "'$remote_addr'";
    }
}
" > $domain
ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/
nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx
echo Finished!