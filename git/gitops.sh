#!/bin/bash
## Tested on a variety of *nix machines and flavors
## This script executes various git commands to streamline a git add, commit, and push operation
## The commands add all files and commit all changes by default
## This script was added primarily for personal convenience

# print usage
usage()
{
  echo '-> This script adds all changes, commits all changes, and pushes them.'
  echo ' $ gitops.sh "commit msg here" <branch|master> <remote|origin> <gitpath|cwd> '
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

# assign remote to 'origin' if no arg
if [ -z "$3" ]; then
  remote="origin"
else remote=$3; fi

# assign dir to current dir if no arg
if [ -z "$4" ]; then
  repo_dir=$(pwd)
else repo_dir=$4; fi

# validate .git dir exists, otherwise run git init
if [ -d "$repo_dir/.git" ]; then
  echo "+ cd \"$repo_dir\""
  cd "$repo_dir"
else
  echo "+ git init"
  git init
  echo "+ cd \"$repo_dir\""
  cd "$repo_dir"
fi

# checkout specified or default branch
if [ ! -z "$branch" ]; then
  echo "+ git checkout $branch"
  git checkout $branch
fi

# check if .gitignore exists, and create it
if [ ! -f .gitignore ]; then
  echo '+ touch .gitignore'
  touch .gitignore
fi

# check if .DS_Store exists, and remove it after adding to .gitignore
if [ -f .DS_Store ]; then
  echo '+ echo "" >> .gitignore; echo ".DS_Store" >> .gitignore'
  echo "" >> .gitignore; echo ".DS_Store" >> .gitignore
  echo '+ git rm .DS_Store; rm -f .DS_Store'
  git rm .DS_Store; rm -f .DS_Store
fi

# perform git ops
# add all untracked files
echo ''
read -n1 -p "> git add . --all [Y/y] " key
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; echo "+ git add . --all"
  git add . --all
fi

# commit all changes
echo ''
read -n1 -p "> git commit -am '$commit_msg' [Y/y] " key
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; echo "+ git commit -am \"$commit_msg\""
  git commit -am "$commit_msg"
fi

# push changes to remote branch
echo ''
read -n1 -p "> git push $remote $branch [Y/y] " key
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; echo "+ git push $remote $branch"
  git push $remote $branch
fi

# get remote origin url
remote_url=$(git config --get "remote.$remote.url")

# print status and url
echo ''
echo "> git ops complete"
echo "> $remote_url"
