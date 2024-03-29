#!/bin/bash
## Tested on Ubuntu and other similar flavors
## This script allows you to quickly configure various git settings.

echo " --> configure-git.sh started ---"

while [ -z "$CHOICE" ]; do
echo " 0 > add a remote url
 1 > set a remote url
 2 > set a default branch name
 3 > set local repository's username
 4 > set local repository's name and email
 5 > set global username
 6 > set global name and email
 7 > exit"
read -n1 -p " --> enter selection: " CHOICE

case $CHOICE in
0)
    echo "";
    while [[ -z "$GIT_URL" ]]
    do
        read -p "  -> remote url to add: " GIT_URL
    done
    read -p "  -> remote name (origin): " GIT_ORIGIN
    if [ -z "$GIT_ORIGIN" ]; then
    GIT_ORIGIN="origin"
    fi
    echo "   + git remote add $GIT_ORIGIN $GIT_URL"
    git remote add $GIT_ORIGIN $GIT_URL
    echo " --> configure-git.sh: complete ---"
;;
1)
    echo "";
    while [[ -z "$GIT_URL" ]]
    do
        read -p "  -> remote url to update: " GIT_URL
    done
    read -p "  -> remote name (origin): " GIT_ORIGIN
    if [ -z "$GIT_ORIGIN" ]; then
    GIT_ORIGIN="origin"
    fi
    echo "   + git remote set-url $GIT_ORIGIN $GIT_URL"
    git remote set-url $GIT_ORIGIN $GIT_URL
    echo " --> configure-git.sh: complete ---"
;;
2)
    echo "";
    while [[ -z "$GIT_BRANCH" ]]
    do
        read -p "  -> default branch: " GIT_BRANCH
    done
    echo "   + git config --replace-all --global init.defaultBranch $GIT_BRANCH"
    git config --replace-all --global init.defaultBranch $GIT_BRANCH
    echo " --> configure-git.sh: complete ---"
;;
3)
    echo "";
    while [[ -z "$GIT_USERNAME" ]]
    do
        read -p "  -> git username: " GIT_USERNAME
    done
    echo "   + git config --replace-all credential.username $GIT_USERNAME"
    git config --replace-all credential.username $GIT_USERNAME
    echo " --> configure-git.sh complete ---"
;;
4)
    echo "";
    while [[ -z "$GIT_NAME" ]]
    do
        read -p "  -> git name: " GIT_NAME
    done
    echo "   + git config --replace-all user.name \"$GIT_NAME\""
    git config --replace-all user.name "$GIT_NAME"
    while [[ -z "$GIT_EMAIL" ]]
    do
        read -p "  -> git email: " GIT_EMAIL
    done
    echo "   + git config --replace-all user.email $GIT_EMAIL"
    git config --replace-all user.email $GIT_EMAIL
echo " --> configure-git.sh: complete ---"
;;
5)
    echo "";
    while [[ -z "$GIT_USERNAME" ]]
    do
        read -p "  -> git username: " GIT_USERNAME
    done
    echo "   + git config --replace-all --global credential.username $GIT_USERNAME"
    git config --replace-all --global credential.username $GIT_USERNAME
    echo " --> configure-git.sh: complete ---"
;;
6)
    echo "";
    while [[ -z "$GIT_NAME" ]]
    do
        read -p "  -> git name: " GIT_NAME
    done
    echo "   + git config --replace-all --global user.name \"$GIT_NAME\""
    git config --replace-all --global user.name "$GIT_NAME"
    while [[ -z "$GIT_EMAIL" ]]
    do
        read -p "  -> git email: " GIT_EMAIL
    done
    echo "   + git config --replace-all --global user.email $GIT_EMAIL"
    git config --replace-all --global user.email $GIT_EMAIL
    echo " --> configure-git.sh: complete ---"
;;
[7])
    echo ""; echo " --> configure-git.sh: exiting ---"
    exit
;;
*)
 echo "  -> Please enter a valid choice"
 unset CHOICE
;;
esac
done
