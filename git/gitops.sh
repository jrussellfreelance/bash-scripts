#!/bin/bash
## Tested on a variety of *nix machines and flavors
## This script executes various git commands to streamline a git add, commit, and push operation
## The commands add all files and commit all changes by default
## This script was added primarily for personal convenience

echo "! gitops.sh started ---"

usage()
{ # print usage
  echo '> this script adds all changes, commits all changes, and pushes them'
  echo '$ gitops.sh "commit msg here"<branch|master> <remote|origin> <gitpath|cwd> -s|--sudo'
}

# helper functions
git_repo_branch() { # prints the repo and branch
  repo=$(git remote -v 2>/dev/null | head -n 1 | sed -nE 's@^.*/(.*).git.*$@\1@p')
  if [ "$repo" != "" ]; then
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    printf "[$repo $branch]"
  else
    printf ""
  fi
}
function gitroot { # print git root folder
  r=$(git rev-parse --git-dir) && r=$(cd "$r" && pwd)/ && echo "${r%%/.git/*}"
}
function gitremote { # print git remotes
  repodir=`gitroot`
  cd $repodir
  git remote -v | grep fetch | awk '{print $2}' | sort | uniq
}
function gitdir { # switch to git root folder
  repodir=`gitroot`
  cd $repodir
}

# variables
commit_msg=
branch=
repo_dir=
remote=
remote_url=
asroot=

# -h or --help displays usage message
if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" ]]; then
	usage
  exit
else commit_msg=$1; fi

# -s or --sudo executes the commands with sudo
if [[ ${!#} == "-s" || ${!#} == "--sudo" ]]; then
	asroot="sudo"
else asroot=""; fi

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

# validate .git dir exists, otherwise offer to initialize
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  # determine git dir
  gitdir
  if [ -d $(pwd) ]; then
    repo_dir=$(pwd)
  fi
  echo "+ cd $repo_dir"
  cd $repo_dir
else # perform git init
  read -n1 -p "> no .git found, initialize a new repository? [Y/y] " key
  if [[ "$key" == "y" || "$key" == "Y" ]] ; then
    echo ""; echo "+ git init"
    $asroot git init
  else # otherwise exit
    echo ""; echo "! no .git directory in $repo_dir, exiting ---"
    exit
  fi
  echo "+ cd \"$repo_dir\""
  cd "$repo_dir"
fi

# checkout specified or default branch
echo ''
read -n1 -p "> git checkout $branch [Y/y] " key
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; echo "+ git checkout $branch"
  $asroot git checkout $branch
else
  echo "- skipping"
fi

# check if .gitignore exists, and create it
if [ ! -f .gitignore ]; then
  echo '+ touch .gitignore'
  $asroot touch .gitignore
fi

# check if .DS_Store exists, and remove it after adding to .gitignore
if [ -f .DS_Store ]; then
  echo '+ echo "" >> .gitignore; echo ".DS_Store" >> .gitignore'
  echo "" >> .gitignore; echo ".DS_Store" >> .gitignore
  echo '+ git rm .DS_Store; rm -f .DS_Store'
  $asroot git rm .DS_Store; rm -f .DS_Store
fi

# perform git ops
# add all untracked files
echo ''
read -n1 -p "> git add . --all [Y/y] " key
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; echo "+ git add . --all"
  $asroot git add . --all
else
  echo "- skipping"
fi

# commit all changes
echo ''
read -n1 -p "> git commit -am \"$commit_msg\" [Y/y] " key
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; echo "+ git commit -am \"$commit_msg\""
  $asroot git commit -am "$commit_msg"
else
  echo "- skipping"
fi

# push changes to remote branch
echo ''
read -n1 -p "> git push $remote $branch [Y/y] " key
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; echo "+ git push $remote $branch"
  $asroot git push $remote $branch
else
  echo "- skipping"
fi

# get remote origin url
remote_url=$(git config --get "remote.$remote.url")

# print status and url
echo ''
echo "! $remote_url"
echo "! gitops.sh complete ---"
