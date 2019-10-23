#!/bin/bash
# Designed for Ubuntu 18.04
echo "An Nginx reverse proxy config file generator"
# Grab variables
while [[ -z "$APPNAME" ]]
do
  read -p "App Name: " APPNAME
done
while [[ -z "$DOMAIN" ]]
do
  read -p "Domain (i.e. sub.website.com):" DOMAIN
done
while [[ -z "$PORT" ]]
do
  read -p "Port: " PORT
done
# Start creating config file
echo "Creating nginx config..."
# Copy contents of default file into new config file
cp ../templates/nginx/reverseproxy /etc/nginx/sites-available/$APPNAME
# Link nginx config to sites-enabled folder
ln -s /etc/nginx/sites-available/$APPNAME /etc/nginx/sites-enabled/$APPNAME
# Replace placeholder values from default file with values from read commands
echo "Replacing values..."
sed -i 's/sub.domain.ext/'$DOMAIN'/g' /etc/nginx/sites-available/$APPNAME
sed -i 's/porthere/'$PORT'/g' /etc/nginx/sites-available/$APPNAME
sed -i 's/appname/'$APPNAME'/g' /etc/nginx/sites-available/$APPNAME
# Restart nginx
echo "Restarting nginx..."
systemctl restart nginx
# Run certbot to generate CA certified ssl certificate
echo "Running certbot..."
certbot --nginx -d $DOMAIN
# Finished
echo "All done! =D"