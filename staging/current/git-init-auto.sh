#!/bin/bash
# Designed for Ubuntu
# This script initializes and configures a new git project for a folder.

##### Functions

usage()
{
    echo 'bash git-init-auto.sh -d /path/to/project -c "Your First Commit Message" -o https://github.com/JacFearsome/bash-scripts.git'
}

##### Main

dir=
origin=
commit=

while [ "$1" != "" ]; do
    case $1 in
        -d | --dir )            shift
                                dir=$1
                                ;;
        -c | --commit )         shift
                                commit=$1
                                ;;
        -o | --origin )         shift
                                origin=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done
if [[ -z "$dir" || -z "$origin" || -z "$commit" ]]; then
	usage
else
cd $dir
git init
git add .
git commit -m $commit
git remote add origin $origin
git push origin master
fi