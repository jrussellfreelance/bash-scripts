#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script condenses the few lines of bash needed for creating a new sudo user into a single command.
# It prompts the current user for the new user's information.
### Assign Color Variables
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7

### Retrieve information for new user
tput setaf $CYAN; echo "Please enter the username for the new sudo user:"
tput setaf $MAGENTA;
while [[ -z "$NAME" ]]
do
    read -p ">> " NAME
done
tput setaf $CYAN; echo "Please enter the password for the new sudo user:"
tput setaf $MAGENTA;
while [[ -z "$PASS1" ]]
do
    read -s -p ">> " PASS1
done
tput setaf $CYAN; echo "Please enter the password again:"
tput setaf $MAGENTA;
while [[ -z "$PASS2" ]]
do
    read -s -p ">> " PASS2
done

tput setaf $BLUE;
sudo useradd -s /bin/bash -d /home/$NAME/ -m -G sudo $NAME
sudo passwd $NAME <<EOF
$PASS1
$PASS2
EOF
tput setaf $WHITE;
