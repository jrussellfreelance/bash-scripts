#!/bin/bash
while [[ -z "$email" ]]
do
    read -p "email   >> " email
done
while [[ -z "$name" ]]
do
    read -p "name    >> " name
done
while [[ -z "$pass" ]]
do
    read -p "password >> " pass
done
git config --global user.email $email
git config --global user.name $name
git config --global user.password $pass