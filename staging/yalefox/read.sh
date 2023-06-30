#!/bin/bash
# Loop through read command and if statement until $key is not ann empty string
while [[ -z "$key" ]]
do
    # read for space or other character
    read -s -n1 -r -p "Press 'space' to Continue, or any key to exit" key
    echo $key
    # if $key is a space, break while loop and continue
    if [[ $key = '' ]] ; then
        echo "worked"
        break
    # if $key is anything else, exit script
    else
        exit
    fi
done
echo "worked 2"