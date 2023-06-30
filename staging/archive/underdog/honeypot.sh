sudo apt update -y										# Update system repositories
sudo apt-get remove docker docker-engine docker.io -y 	# Remove any old versions of docker
sudo apt install docker.io -y 							# Install docker
sudo systemctl start docker 							# Start Docker
sudo systemctl enable docker 							# Enable Docker on boot
docker --version 										# Check version of docker (to see if it installed)


ufw allow 443 																	# open firewall up on 443 for SSL
wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash # Install the repos for OpenLiteSpeed
apt-get install openlitespeed -y												# Install OpenLiteSpeed
apt-get install lsphp73 -y 														# Install PHP for OpenLiteSpeed
ln -sf /usr/local/lsws/lsphp73/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp5 		# Sets up symbolic links for OpenLiteSpeed
/usr/local/lsws/bin/lswsctrl start 												# Start OpenLiteSpeed

sed -i 's/*:8088/*:80/g' /usr/local/lsws/conf/httpd_config.conf 				# Adds the mapping from port 8088 to port 80
systemctl restart lsws 															# Restarts OpenLiteSpeed


OLS_PASSWORD=$(openssl rand -base64 12)
/usr/local/lsws/admin/misc/admpass.sh << EOF
admin
$OLS_PASSWORD
$OLS_PASSWORD
EOF

IP=$(curl -s icanhazip.com)

echo " URL      ➜ http://$IP:7080 "						# Prints link to Admin Panel
echo " username ➜ admin " 								# Prints username
echo " password ➜ $OLS_PASSWORD " 						# Prints password


sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update -y

sudo apt-get install certbot -y

sudo apt-get install python3-certbot-dns-cloudflare -y


mkdir -p ~/.secrets/certbot/




echo "🦊 ➜ Please enter your Cloudflare email exactly:"
read CF_EMAIL

echo "🦊 ➜ Please paste your Cloudflare global API key:"
read CF_GLOBAL

cat <<EOF>> ~/.secrets/certbot/cloudflare.ini
# Cloudflare API credentials used by Certbot
dns_cloudflare_email = $CF_EMAIL
dns_cloudflare_api_key = $CF_GLOBAL
EOF

chmod 600 ~/.secrets/certbot/cloudflare.ini


echo "🦊 ➜ Please enter your domain or subdomain:"
read DOMAIN_NAME
mkdir -p ~/usr/local/lsws/$DOMAIN_NAME/html


certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini \
  -d $DOMAIN_NAME


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
