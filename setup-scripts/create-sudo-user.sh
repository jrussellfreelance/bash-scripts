#!/bin/bash
# Designed for Ubuntu
# create-sudo-user.sh - A script that creates a new sudo user via prompts

### Assign Color Variables
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6

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
useradd -s /bin/bash -d /home/$NAME/ -m -G sudo $NAME
passwd $NAME <<EOF
$PASS1
$PASS2
EOF
fi
