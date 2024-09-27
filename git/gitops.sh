#!/bin/bash
## Tested on a variety of *nix machines and flavors
## This script executes various git commands to streamline a git add, commit, and push operation
## The commands add all files and commit all changes by default
## This script was added primarily for personal convenience

echo -e "! gitops.sh started ---"

usage()
{ # print usage
  echo -e '> this script adds all changes, commits all changes, and pushes them'
  echo -e '$ gitops.sh -y -m "msg" -b <branch|master> -r <remote|origin> -d <gitpath|pwd>'
  echo -e '$ gitops.sh --yes --msg "commit msg" ---branch <branch|master> -r | --remote <remote|origin> -d | --dir <gitpath|cwd>'
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
YES=1
commit_msg="updated on $(date +'%m-%d-%Y at %T')"
branch="master"
repo_dir=$(pwd)
remote="origin"
remote_url=

while [ "$1" != "" ]; do
case $1 in
  -h | --help)
    shift
    usage
    exit
    ;;
  -y | --yes)
    shift
    export YES=0
    ;;
  -m | --msg)
    shift
    commit_msg=$1
    ;;
  -b | --branch)
    shift
    branch=$1
    ;;
  -r | --remote)
    shift
    remote=$1
    ;;
  -d | --dir)
    shift
    repo_dir=$1
    ;;
  *)
    shift
  esac
  shift
done

# validate .git dir exists, otherwise offer to initialize
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo -e "+ cd \"$repo_dir\""
  cd "$repo_dir"
else # perform git init
  if [[ "$YES" == 0 ]] ; then
    key="y"
  else
    read -n1 -p "> no .git found, initialize a new repository? [Y/y] " key
  fi
  if [[ "$key" == "y" || "$key" == "Y" ]] ; then
    echo -e "+ git init"
    git init
  else # otherwise exit
    echo -e "! no .git directory in $repo_dir, exiting ---"
    exit
  fi
  cd "$repo_dir"
  echo -e "+ cd \"$repo_dir\""
fi

# check if the branch exists and save checkout cmd
if git show-ref --verify --quiet refs/heads/$branch; then
  echo -e "\n! $branch branch exists"
  checkout_cmd="git checkout $branch"
else
  echo -e "\n! $branch branch doesn't exist"
  checkout_cmd="git checkout -b $branch"
fi
if [[ "$YES" == 0 ]] ; then
  key="y"
else
  read -n1 -p "> $checkout_cmd [Y/y] " key
fi
# run git checkout command
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; $checkout_cmd
  echo -e "+ $checkout_cmd\n"
else
  echo -e "- skipping\n"
fi

# check if .gitignore exists, create if it doesn't
if [ ! -f .gitignore ]; then
  touch .gitignore
  echo -e '+ touch .gitignore\n'
fi

# if .DS_Store exists then remove it and add to .gitignore
if [ -f .DS_Store ]; then
  echo "" >> .gitignore; echo ".DS_Store" >> .gitignore
  echo -e '+ echo "" >> .gitignore; echo ".DS_Store" >> .gitignore\n'
  git rm .DS_Store; rm .DS_Store
  echo -e '+ git rm .DS_Store; rm .DS_Store\n'
fi

# perform git ops
# add all untracked files
if [[ "$YES" == 0 ]] ; then
  key="y"
else
  read -n1 -p "> git add . --all [Y/y] " key
fi
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; git add . --all
  echo -e "+ git add . --all\n"
else
  echo -e "- skipping\n"
fi

# commit all changes
if [[ "$YES" == 0 ]] ; then
  key="y"
else
  read -n1 -p "> git commit -am \"$commit_msg\" [Y/y] " key
fi
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; git commit -am "$commit_msg"
  echo -e "+ git commit -am \"$commit_msg\"\n"
else
  echo -e "- skipping\n"
fi

# push changes to remote branch
if [[ "$YES" == 0 ]] ; then
  key="y"
else
  read -n1 -p "> git push $remote $branch [Y/y] " key
fi
if [[ "$key" == "y" || "$key" == "Y" ]] ; then
  echo ""; git push $remote $branch
  echo -e "+ git push $remote $branch"
else
  echo -e "- skipping"
fi

echo -e "\n! git ops completed ---"
