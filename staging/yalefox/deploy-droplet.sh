#!/bin/bash
# Designed for Ubuntu 18.04
# This script deploys a new droplet on Digital Ocean via their API
#### Assign Color Variables ####
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7
tput setaf $CYAN; echo "Installing jq dependency..."
tput setaf $BLUE; sudo apt install jq -y

# Ask user for API Token
tput setaf $CYAN; echo "First we need your DigitalOcean API Token:"
while [[ -z "$TOKEN" ]]
do
    read -p ">> " TOKEN
done
tput setaf $BLUE;

# Grab all SSH keys through API and create string
tput setaf $CYAN; echo "Adding all SSH keys associated with the team..."
tput setaf $BLUE;
ssh_data=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" "https://api.digitalocean.com/v2/account/keys")
SSH="["
while read ln ;do 
	SSH+=$ln","
done < <( echo $ssh_data | jq -r ".ssh_keys | .[] | .id")
SSH+="]"
SSH=$(echo $SSH | sed 's/\(.*\),/\1/')

# Print Sizes
tput setaf $CYAN; echo "Retrieving the list of droplet sizes..."
tput setaf $BLUE;
size_data=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" "https://api.digitalocean.com/v2/sizes")
tput setaf $CYAN; echo "What size should the droplet be? Here are the options:"
tput setaf $MAGENTA; echo $size_data | jq -r ".sizes | .[] | .slug"
# Ask user to enter size
while [[ -z "$SIZE" ]]
do
tput setaf $CYAN; read -p ">> " SIZE
done
# Ask for droplet name
echo "What should the name of the droplet be?"
while [[ -z "$NAME" ]]
do
read -p ">> " NAME
done
tput setaf $BLUE;
# Create droplet
droplet_data=$(curl -X POST -H "Content-Type: application/json" \
			 -H "Authorization: Bearer $TOKEN" \
			 -d "{\"name\":\"$NAME\",\"region\":\"nyc3\",\"size\":\"$SIZE\",\"image\":\"ubuntu-18-04-x64\",\"ssh_keys\":$SSH,\"backups\":false,\"ipv6\":false,\"user_data\":null,\"private_networking\":null,\"volumes\": null,\"tags\":null}" \
				"https://api.digitalocean.com/v2/droplets")
# echo $droplet_data | jq
# Print information
tput setaf $MAGENTA;
echo " ID          ➜ $(echo $droplet_data | jq ".droplet | .id")"
echo " Name        ➜ $(echo $droplet_data | jq ".droplet | .name")"
echo " Description ➜ $(echo $droplet_data | jq ".droplet | .desccription")"

tput setaf $WHITE;