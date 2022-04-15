#!/usr/bin/env bash

# Tested on Ubuntu 18.04 LTS
# This script allows you to quickly configure Git.

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
    1 >> Set global user settings
    2 >> Set local user settings
    3 >> Set remote origin url
    X >> Exit
"
tput setaf $CYAN; read -n1 -p "    Enter your selection >> " CHOICE

case $CHOICE in
1)
    echo "";
    while [[ -z "$GIT_USERNAME" ]]
    do
        read -p "        git username >> " GIT_USERNAME
    done
    while [[ -z "$GIT_EMAIL" ]]
    do
        read -p "        git email    >> " GIT_EMAIL
    done
    while [[ -z "$GIT_NAME" ]]
    do
        read -p "        git name     >> " GIT_NAME
    done
    git config --global credential.username $GIT_USERNAME
    git config --global user.email $GIT_EMAIL
    git config --global user.name $GIT_NAME
;;
2)
    echo "";
    while [[ -z "$GIT_USERNAME" ]]
    do
        read -p "        git username >> " GIT_USERNAME
    done
    while [[ -z "$GIT_EMAIL" ]]
    do
        read -p "        git email    >> " GIT_EMAIL
    done
    while [[ -z "$GIT_NAME" ]]
    do
        read -p "        git name     >> " GIT_NAME
    done
    git config credential.username $GIT_USERNAME
    git config user.email $GIT_EMAIL
    git config user.name $GIT_NAME
;;
3)
    while [[ -z "$GIT_URL" ]]
    do
        read -p "        remote origin url >> " $GIT_URL
    done
    git remote set-url origin $GIT_URL
;;
[xX]) 
    tput setaf $RED; echo "";
    echo "    >> Exiting!"
    tput setaf $WHITE;
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
