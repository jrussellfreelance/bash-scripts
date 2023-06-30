#!/bin/bash
echo "A ELK stack install script"
# Grab variables
while [[ -z "$KIBANAPASS" ]]
do
    read -s -p "Kibana Password: " KIBANAPASS
done
while [[ -z "$URL" ]]
do
    read -p "Kibana FQDN: " URL
done
# Update system and install prereqs
echo "Updating system and installing prereqs..."
apt-get update && apt-get -y upgrade
apt-get --assume-yes install apt-transport-https software-properties-common wget
# Install Java
echo "Installing Java..."
apt --assume-yes install openjdk-8-jdk
# Install ELK packages
echo "Installing ELK and Nginx packages..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
apt-get update
apt-get --assume-yes install elasticsearch kibana nginx logstash
echo "Installing certbot..."
add-apt-repository ppa:certbot/certbot
apt-get update
apt-get --assume-yes install python-certbot-nginx
# Enable ELK services
echo "Enabling services..."
systemctl enable elasticsearch
systemctl enable kibana
systemctl enable nginx
# Configure nginx
echo "Configuring Nginx..."
echo "admin:$(openssl passwd -apr1 $KIBANAPASS)" | sudo tee -a /etc/nginx/htpasswd.kibana
rm -f /etc/nginx/sites-enabled/default
cp ../templates/nginx/elk /etc/nginx/sites-available/elk
ln -s /etc/nginx/sites-available/elk /etc/nginx/sites-enabled/elk
sed -i 's/sub.domain.ext/'$URL'/g' /etc/nginx/sites-available/elk
# Restart services
echo "Restarting services..."
systemctl restart elasticsearch
systemctl restart kibana
systemctl restart nginx
# Run certbot
echo "Running cerbot..."
certbot --nginx -d $URL
# Echo post installation instructions
echo "All done! Additional steps:"
echo " - Edit elasticsearch config as needed: sudo nano /etc/elasticsearch/elasticsearch.yml"
echo " - Edit kibana config as needed: sudo nano /etc/kibana/kibana.yml"