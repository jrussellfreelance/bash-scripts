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
apt update -y                                       
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

# LSWS one click install with Wordpress
wget --no-check-certificate https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh


# OLS Admin Password
OLS_PASSWORD=$(openssl rand -base64 12)
/usr/local/lsws/admin/misc/admpass.sh << EOF
admin
$OLS_PASSWORD 
$OLS_PASSWORD
EOF

# Restart OpenLiteSpeed
systemctl restart lsws

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
echo " Sys User  ➜ $NAME"
echo " Sys Pass  ➜ $USER_PASSWORD"
echo " OLS User  ➜ admin"
echo " OLS Pass  ➜ $OLS_PASSWORD"
echo " OLS URL   ➜ http://$IP:7080"
echo " WP  URL   ➜ http://$IP"