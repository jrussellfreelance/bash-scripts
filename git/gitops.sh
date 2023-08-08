#!/bin/bash
## Tested on a variety of *nix machines and flavors
## This script executes various git commands to streamline a git add, commit, and push operation
## The commands add all files and commit all changes by default
## This script was added primarily for personal convenience

# print usage
usage()
{
    echo '-> This script adds all changes, commits all changes, and pushes them. Usage:'
    echo '-> gitops.sh "commit msg here" <branch|master> <gitpath|cwd> <remote|origin>'
}

# variables
commit_msg=
branch=
repo_dir=
remote=
remote_url=

# check for the help flag and set the commit message
if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" ]]; then
	usage
    exit
else commit_msg=$1; fi

# assign branch to 'master' if no arg
if [ -z "$2" ]; then
    branch="master"
else branch=$2; fi

# assign dir to current dir if no arg
if [ -z "$3" ]; then
    repo_dir=$(pwd)
else repo_dir=$3; fi

# assign remote to 'origin' if no arg
if [ -z "$4" ]; then
    remote="origin"
else remote=$4; fi

# validate .git dir exists
if [ -d "$repo_dir/.git" ]; then
    cd "$repo_dir"
else
    echo "-> The specified directory does not contain .git, exiting..."
    exit
fi

# check if .gitignore exists, and create it
if [ ! -f .gitignore ]; then
  echo "-> .gitignore doesn't exist, creating it..."
  echo "" > .gitignore
fi

# check if .DS_Store exists, and remove it after adding to .gitignore
if [ -f .DS_Store ]; then
  echo "-> .DS_Store exists, adding to .gitignore, removing from source and from disk..."
  echo "" >> .gitignore; echo ".DS_Store" >> .gitignore
  git rm .DS_Store
  rm -f .DS_Store
fi

# perform git ops
# add all untracked files
echo ''
read -n1 -p "-> X to skip: git add . --all " git_add_key
if [[ "$git_add_key" != "x" && "$git_add_key" != "X" ]] ; then
  echo "-> Adding all changes"
  git add . --all
fi

# commit all changes
echo ''
read -n1 -p "-> X to skip: git commit -am '$commit_msg' " git_comm_key
if [[ "$git_comm_key" != "x" && "$git_comm_key" != "X" ]] ; then
  echo "-> Committing all changes"
  git commit -am "$commit_msg"
fi

# push changes to remote branch
echo ''
read -n1 -p "-> X to skip: git push $remote $branch " git_push_key
if [[ "$git_push_key" != "x" && "$git_push_key" != "X" ]] ; then
  echo "-> Pushing all changes"
  git push $remote $branch
fi

# get remote origin url
remote_url=$(git config --get "remote.$remote.url")

# print status and url
echo ''
echo "-> Repo URL: $remote_url"
echo "-> Git  Ops: Complete ---"
