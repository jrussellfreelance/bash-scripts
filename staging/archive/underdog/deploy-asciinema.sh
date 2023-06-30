#!/bin/bash
# This script performs set up tasks for an Underdog server

### Apt Setup
echo "Let's get started! Starting with some apt configuration..."
apt update
apt -y upgrade
apt -y dist-upgrade
apt -y autoremove
### Create sudo user
echo "Creating a sudo user for you to use..."
NAME="wwwadmin"
USER_PASSWORD=$(openssl rand -base64 12)
useradd -s /bin/bash -d /home/$NAME/ -m -G sudo $NAME
passwd $NAME <<EOF > /dev/null
$USER_PASSWORD
$USER_PASSWORD
EOF
# When you log in, run "su wwwadmin" to become the correct user

### Docker & docker-compose
apt remove remove docker docker-engine docker.io containerd runc
apt  install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common git -y   
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88    
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt update
apt install docker-ce docker-ce-cli containerd.io -y
systemctl start docker              
systemctl enable docker
curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

### Certbot
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
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
certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini \
  -d $DOMAIN_NAME

### LSWS
# One click install
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

### Setup Asciinema
echo "🦊 ➜ Hello! Please enter your domain name(example.com/terminal):"
read DOMAIN_NAME
cd /rootcd 
git clone --recursive https://github.com/asciinema/asciinema-server.git
cd asciinema-server
cp .env.production.sample .env.production
sed -i "s/URL_HOST=localhost/URL_HOST=$DOMAIN_NAME/g" .env.production
SECRET_KEY=$(date +%s | sha256sum | base64 | head -c 64 ; echo)
sed -i "s/SECRET_KEY_BASE=/SECRET_KEY_BASE=$SECRET_KEY/g" .env.production

docker-compose up -d postgres
docker-compose run --rm phoenix setup
docker-compose up -d


# Get IP Address
IP=$(curl -s icanhazip.com)

# Print information
echo " Username  ➜ $NAME"
echo " Password  ➜ $USER_PASSWORD"
echo " Admin URL ➜ http://$IP:7080 "          # Prints link to Admin Panel
echo " OLS User  ➜ admin "                # Prints username
echo " Password  ➜ $OLS_PASSWORD "            # Prints password