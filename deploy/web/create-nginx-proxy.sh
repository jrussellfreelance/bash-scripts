#!/bin/bash
## Tested on Ubuntu and similar flavors
## This script generates Nginx reverse proxy configurations
echo "! nginx reverse proxy generation started"
echo "---"

usage()
{ # print usage
  echo '> generates Nginx reverse proxy configurations'
  echo '$ ./create-nginx-proxy.sh <listening domains by space inside quotes> <proxy URL>'
}

# argument variables
domains=
maindomain=
proxypass=

# -h or --help displays usage message
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	usage
  exit
fi

# assign domain to $1 or prompt for domain
if [[ -z "$1" ]]; then
  while [[ -z "$domains" ]]
  do
    read -p "> server_name value: " domains
  done
else
  domains=$1
  echo "! server_name value: $domains"
fi
maindomain=$(echo $domains | cut -d' ' -f1)
echo "! primary domain: $maindomain"

# assign $proxypass to $2 or prompt for proxy_pass URL
if [ -z "$2" ]; then
  while [[ -z "$proxypass" ]]
  do
    read -p "> proxy_pass value: " proxypass
  done
else
  proxypass=$2
  echo "! proxy_pass value: $proxypass"
fi

# path variables
sitesa="/etc/nginx/sites-available/"
configfile="$sitesa$maindomain"
sitese="/etc/nginx/sites-enabled/"
configlink="$sitese$maindomain"

if [[ -f $configfile || -f $configlink || -L $configlink ]] ; then
    echo "! previous config files exist for this domain"
    # ask to remove them
    read -p "> delete any old config files in /etc/nginx/sites-*? [Y/y] " key
    if [[ "$key" == "y" || "$key" == "Y" ]] ; then
        # remove preexisting config file if exists
        if [[ -f $configfile ]] ; then
            echo "+ sudo rm -f $configfile"
            sudo rm -f $configfile
        fi
        if [[ -f $configlink ]] ; then
            echo "+ sudo rm -f $configlink"
            sudo rm -f $configlink
        fi
        if [[ -L $configlink ]] ; then
            echo "+ sudo unlink $configlink"
            sudo unlink $configlink
        fi
    else
        echo "! not deleting any existing config files"
        echo "! nginx reverse proxy generation exiting ---"
        exit 1
    fi
fi

# cd to sites-available and create config file
echo "+ touch $configfile"
sudo touch $configfile

# write reverse proxy configuration to file
echo "> adding config contents to new file"
sudo cat <<'EOF' > $configfile
server {
    listen 80;
    listen [::]:80;
    server_name @@@domains@@@;
    client_max_body_size 2048M;
    location / {
        proxy_pass @@@proxypass@@@;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
EOF

# replace placeholder values with bash variables
echo "> updating config contents with sed"
sed -i "s|@@@domains@@@|${domains}|g" $configfile
sed -i "s|@@@proxypass@@@|${proxypass}|g" $configfile

# create symlink to sites-enabled for new config sites-available
read -p "> create symlink to sites-enabled? [Y/y] " key
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
    echo "+ sudo ln -s $configfile $sitese"
    sudo ln -s $configfile $sitese
fi

echo "+ sudo nginx -t"
sudo nginx -t 2>/dev/null > /dev/null
if [[ $? == 0 ]] ; then
    echo "> config test successful"

    # reload nginx
    echo "+ sudo systemctl reload nginx"
    sudo systemctl reload nginx

    # ask to configure certbot
    read -p "> configure certbot for the primary domain? [Y/y] " key
    if [[ "$key" == "y" || "$key" == "Y" ]] ; then
        echo "+ sudo certbot --nginx -d $maindomain"
        sudo certbot --nginx -d $domains
    fi
else
    echo "> config test failed, please check the config file"
fi
echo "---"
echo "! configuration file  : $configfile"
echo "! listening domain(s) : $domains"
echo "! nginx reverse proxy generation finished"