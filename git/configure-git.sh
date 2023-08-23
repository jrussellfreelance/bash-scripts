#!/bin/bash
# Tested on Ubuntu 18.04 LTS
# This script allows you to quickly configure various git settings.

while [ -z "$CHOICE" ]; do
echo "
    1 >> Set a remote path
    2 >> Set a default branch name
    3 >> Set a repository's username
    4 >> Set a repository's name and email
    5 >> Set the global username
    6 >> Set the global name and email
    X >> Exit
"
read -n1 -p "    Enter your selection >> " CHOICE

case $CHOICE in
1)
    while [[ -z "$GIT_URL" ]]
    do
        read -p "        remote url >> " GIT_URL
    done
    read -p "        remote name (origin) >> " GIT_ORIGIN
    if [ -z "$GIT_ORIGIN" ]; then
        GIT_ORIGIN="origin"
    fi
    git remote set-url $GIT_ORIGIN $GIT_URL
;;
2)
    echo "";
    while [[ -z "$GIT_BRANCH" ]]
    do
        read -p "        default branch >> " GIT_BRANCH
    done
    git config --global init.defaultBranch $GIT_BRANCH
;;
3)
    echo "";
    while [[ -z "$GIT_USERNAME" ]]
    do
        read -p "        git username >> " GIT_USERNAME
    done
    git config credential.username $GIT_USERNAME
;;
4)
    echo "";
    while [[ -z "$GIT_NAME" ]]
    do
        read -p "        git name     >> " GIT_NAME
    done
    git config user.name $GIT_NAME
    while [[ -z "$GIT_EMAIL" ]]
    do
        read -p "        git email    >> " GIT_EMAIL
    done
    git config user.email $GIT_EMAIL
;;
5)
    echo "";
    while [[ -z "$GIT_USERNAME" ]]
    do
        read -p "        git username >> " GIT_USERNAME
    done
    git config --global credential.username $GIT_USERNAME
;;
6)
    echo "";
    while [[ -z "$GIT_NAME" ]]
    do
        read -p "        git name     >> " GIT_NAME
    done
    git config --global user.name $GIT_NAME
    while [[ -z "$GIT_EMAIL" ]]
    do
        read -p "        git email    >> " GIT_EMAIL
    done
    git config --global user.email $GIT_EMAIL
    echo "";
;;
[xX]) 
    echo "";
    echo "    >> Exiting!"
    exit
;;
*)
    echo "
    >> Please enter a valid choice"
    unset CHOICE
;;
esac
done
