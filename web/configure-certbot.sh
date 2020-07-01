#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script allows you to quickly install and configure certbot.

### Assign Color Variables
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7

while [ -z "$CHOICE" ]; do
tput setaf $MAGENTA;
echo "
    1 >> Install Certbot
    2 >> Run Certbot
    X >> Exit
"
read -n1 -p "    Enter your selection >> " CHOICE

case $CHOICE in
	1)
	while [[ -z "$ADDON" ]]
	do
	    read -n1 -p "
    >>> Install (C)loudflare or (N)ginx addon? >> " ADDON

	    tput setaf $BLUE;
	    case $ADDON in
	    	[cC]) 
			apt-get install software-properties-common -y
			add-apt-repository ppa:certbot/certbot
			apt-get update
			apt-get install certbot python3-certbot-dns-cloudflare -y
			mkdir -p ~/.secrets/certbot/

			while [[ -z "$CF_EMAIL" ]]
			do
			read -p "Cloudflare Email          >> " CF_EMAIL
			done

			while [[ -z "$CF_GLOBAL" ]]
			do
			read -p "Cloudflare Global API Key >> " CF_GLOBAL
			done

			cat <<EOF >> ~/.secrets/certbot/cloudflare.ini
# Cloudflare API credentials used by Certbot
dns_cloudflare_email = $CF_EMAIL
dns_cloudflare_api_key = $CF_GLOBAL
EOF
			chmod 600 ~/.secrets/certbot/cloudflare.ini
			;;
	    	[nN]) 
			apt-get install software-properties-common -y
			add-apt-repository ppa:certbot/certbot
			apt-get update
			apt-get install certbot python3-certbot-nginx -y
			;;
			*)
		    tput setaf $RED; echo ">> Please enter a valid choice"
		    unset ADDON
		    ;;
		esac
	done
	;;
	2)
	while [[ -z "$RUN" ]]
	do
	    read -n1 -p "
    >>> Run (C)loudflare or (N)ginx addon? >> " RUN

		tput setaf $MAGENTA;
	    case $RUN in
	    	[cC]) 
			while [[ -z "$DOMAIN" ]]
			do
			read -p "
			Domain >> " DOMAIN
			done
			certbot certonly \
			  --dns-cloudflare \
			  --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini \
			  -d $DOMAIN
			;;
	    	[nN]) 
			while [[ -z "$DOMAIN" ]]
			do
			read -p "
			Domain >> " DOMAIN
			done
			certbot \
			  --nginx \
			  -d $DOMAIN
			;;
			*)
		    tput setaf $RED; echo "
		    >> Please enter a valid choice"
		    unset RUN
		    ;;
		esac
	done
	;;
	[xX]) 
    exit
    ;;
	*)
    tput setaf $RED; echo "
    >> Please enter a valid choice"
    unset CHOICE
    ;;

esac
done
tput setaf $WHITE;