#!/bin/bash
# Designed for Ubuntu 18.04
echo "An Nginx php-fpm config file generator"
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
  read -p "PHP-FPM Port: " PORT
done
while [[ -z "$ROOTPATH" ]]
do
  read -p "Path to website files: " ROOTPATH
done
# Start creating config file
echo "Creating nginx config..."
# Copy contents of default file into new config file
cp ../templates/nginx/phpfpm /etc/nginx/sites-available/$APPNAME
# Link nginx config to sites-enabled folder
ln -s /etc/nginx/sites-available/$APPNAME /etc/nginx/sites-enabled/$APPNAME
# Replace placeholder values from default file with values from read commands
echo "Replacing values..."
sed -i 's/sub.domain.ext/'$DOMAIN'/g' /etc/nginx/sites-available/$APPNAME
sed -i 's/900x/'$PORT'/g' /etc/nginx/sites-available/$APPNAME
sed -i 's/appname/'$APPNAME'/g' /etc/nginx/sites-available/$APPNAME
sed -i 's/root_path_here/"$ROOTPATH"/g' /etc/nginx/sites-available/$APPNAME
# Create php-fpm pool
echo "Creating PHP-FPM config..."
cp ../templates/php-fpm/phpfpm.conf /etc/php/7.2/fpm/pool.d/$APPNAME.conf
echo "Replacing values..."
sed -i 's/pool_name_here/'$APPNAME'/g' /etc/php/7.2/fpm/pool.d/$APPNAME.conf
sed -i 's/900x/'$PORT'/g' /etc/php/7.2/fpm/pool.d/$APPNAME.conf
# Restart services
echo "Restarting services..."
systemctl restart php7.2-fpm
systemctl restart nginx
# Run certbot to generate CA certified ssl certificate
echo "Running certbot..."
certbot --nginx -d $DOMAIN
# Finished
echo "All done! =D"