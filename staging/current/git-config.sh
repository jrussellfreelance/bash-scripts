#!/bin/bash
# Tested on Ubuntu 18.04
# This script initializes git global settings
while [[ -z "$email" ]]
do
    read -p "email   >> " email
done
while [[ -z "$name" ]]
do
    read -p "name    >> " name
done
git config --global user.email $email
git config --global user.name $name