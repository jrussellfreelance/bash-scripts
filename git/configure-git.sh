#!/bin/bash
## Tested on Ubuntu and other similar flavors
## This script allows you to quickly configure various git settings.

# helper functions
function gitroot { # print git root folder
  r=$(git rev-parse --git-dir) && r=$(cd "$r" && pwd)/ && echo "${r%%/.git/*}"
}
function gitdir { # switch to git root folder
  repodir=`gitroot`
  cd $repodir
}
function gitremote { # print git remotes
  repodir=`gitroot`
  cd $repodir
  git remote -v | grep fetch | awk '{print $2}' | sort | uniq
}
gitrepo() { # prints the repo and branch
  gitdir
  repo=$(git remote -v 2>/dev/null | head -n 1 | sed -nE 's@^.*/(.*).git.*$@\1@p')
  if [ "$repo" != "" ]; then
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    printf "$repo"
  else
    printf ""
  fi
}
gitbranch() { # prints the repo and branch
  gitdir
  repo=$(git remote -v 2>/dev/null | head -n 1 | sed -nE 's@^.*/(.*).git.*$@\1@p')
  if [ "$repo" != "" ]; then
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    printf "$branch"
  else
    printf ""
  fi
}

# init
gitdir # switch to root of git dir

# print out options and run script
echo "! git configuration script !"
echo "----------------------------"
echo "   repo: $(gitrepo)"
echo " branch: $(gitbranch)"
echo "   path: $(gitroot)"
i=0; while IFS= read -r giturl; do
  if [[ i -eq 0 ]] ; then
    printf " remote: - %s\n" "$giturl"
  else
    printf "         - %s\n" "$giturl"
  fi
  ((i++))
done <<< "$(gitremote)"
echo "--------------------------"

while [ -z "$CHOICE" ]; do
echo "
 1 > set global credentials
 2 > set repo credentials
 3 > set remote urls
 4 > set default branch
 5 > set defaults for merging
 6 > set gitweb values
 7 > exit
"
read -n1 -p " --> enter selection: " CHOICE

case $CHOICE in
1)
    echo ""
    while [[ -z "$GLOBAL_USERNAME" ]]
    do
        read -p "  -> global username: " GLOBAL_USERNAME
    done
    echo "+ git config --replace-all --global credential.username $GLOBAL_USERNAME"
    git config --replace-all --global credential.username $GLOBAL_USERNAME
    while [[ -z "$GLOBAL_NAME" ]]
    do
        read -p "  -> global owner: " GLOBAL_NAME
    done
    echo "+ git config --replace-all --global user.name \"$GLOBAL_NAME\""
    git config --replace-all --global user.name "$GLOBAL_NAME"
    while [[ -z "$GLOBAL_EMAIL" ]]
    do
        read -p "  -> global email: " GLOBAL_EMAIL
    done
    echo "+ git config --replace-all --global user.email $GLOBAL_EMAIL"
    git config --replace-all --global user.email $GLOBAL_EMAIL
;;
2)
    echo "";
    while [[ -z "$GIT_USERNAME" ]]
    do
        read -p "  -> repo username: " GIT_USERNAME
    done
    echo "+ git config --replace-all credential.username $GIT_USERNAME"
    git config --replace-all credential.username $GIT_USERNAME
    while [[ -z "$GIT_NAME" ]]
    do
        read -p "  -> repo owner: " GIT_NAME
    done
    echo "+ git config --replace-all user.name \"$GIT_NAME\""
    git config --replace-all user.name "$GIT_NAME"
    while [[ -z "$GIT_EMAIL" ]]
    do
        read -p "  -> repo email: " GIT_EMAIL
    done
    echo "+ git config --replace-all user.email $GIT_EMAIL"
    git config --replace-all user.email $GIT_EMAIL
;;
3)
    echo ""
    # print out remote urls
    git remote -v
    # update remote url
    read -n1 -p "  -> update an existing remote [Y/y] " key
    if [[ "$key" == "y" || "$key" == "Y" ]] ; then
      echo ""
      while [[ -z "$GIT_ORIGIN" ]]
      do
          read -p "  -> remote name: " GIT_ORIGIN
      done
      while [[ -z "$GIT_URL" ]]
      do
          read -p "  -> remote url: " GIT_URL
      done
      echo "+ git remote set-url $GIT_ORIGIN $GIT_URL"
      git remote set-url $GIT_ORIGIN $GIT_URL
    fi
    # add remote url
    read -n1 -p "  -> add a remote url [Y/y] " key
    if [[ "$key" == "y" || "$key" == "Y" ]] ; then
      echo "";
      while [[ -z "$ADD_ORIGIN" ]]
      do
          read -p "  -> remote name: " ADD_ORIGIN
      done
      while [[ -z "$ADD_URL" ]]
      do
          read -p "  -> remote url: " ADD_URL
      done
      echo "+ git remote add $ADD_ORIGIN $ADD_URL"
      git remote add $ADD_ORIGIN $ADD_URL
    fi
    # remove remote url
    read -n1 -p "  -> remove an existing remote [Y/y] " key
    if [[ "$key" == "y" || "$key" == "Y" ]] ; then
      echo ""
      while [[ -z "$DEL_ORIGIN" ]]
      do
          read -p "  -> remote name: " DEL_ORIGIN
      done
      echo "+ git remote remove $DEL_ORIGIN"
      git remote remove $DEL_ORIGIN
    fi
;;
4)
    echo "";
    while [[ -z "$GIT_BRANCH" ]]
    do
        read -p "  -> default branch: " GIT_BRANCH
    done
    echo "+ git config --replace-all --global init.defaultBranch $GIT_BRANCH"
    git config --replace-all --global init.defaultBranch $GIT_BRANCH
;;
5)
    # update remote url
    echo ""
    read -n1 -p " ->  git config pull.rebase false [Y/y] # merge (default) " key
    if [[ "$key" == "y" || "$key" == "Y" ]] ; then
      echo ""
      echo "+ git config pull.rebase false"
      git config pull.rebase false
      break
    fi
    read -n1 -p " ->  git config pull.rebase true [Y/y] # rebase " key
    if [[ "$key" == "y" || "$key" == "Y" ]] ; then
      echo ""
      echo "+ git config pull.rebase true"
      git config pull.rebase true
      break
    fi
    read -n1 -p " ->  git config pull.ff only [Y/y] # fast-forward only " key
    if [[ "$key" == "y" || "$key" == "Y" ]] ; then
      echo "+ git config pull.ff only"
      git config pull.ff only
      break
    fi
;;
6)
    echo ""
    # create and edit HTML readme file
    touch .git/README.html
    read -n1 -p " ->  edit README.html with nano [N/n] or vim [V/v] " key
    if [[ "$key" == "n" || "$key" == "N" ]] ; then
      nano .git/README.html
    elif [[ "$key" == "v" || "$key" == "V" ]] ; then
      vim .git/README.html
    fi
    # set project description and write to file
    read -p "  -> project description: " GIT_DESCRIPTION
    echo "+ git config gitweb.description '$GIT_DESCRIPTION'"
    git config gitweb.description "$GIT_DESCRIPTION"
    echo $GIT_DESCRIPTION > .git/description
    # set project category
    read -p "  -> project category: " GIT_CATEGORY
    echo "+ git config gitweb.category '$GIT_CATEGORY'"
    git config gitweb.category "$GIT_CATEGORY"
    # set project clone url
    read -p "  -> project cloneurl: " GIT_CLONEURL
    echo "+ git config gitweb.cloneurl '$GIT_CLONEURL'"
    git config gitweb.cloneurl "$GIT_CLONEURL"
    # set project owner
    read -p "  -> project owner: " GIT_OWNER
    echo "+ git config gitweb.owner '$GIT_OWNER'"
    git config gitweb.owner "$GIT_OWNER"
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
echo " --> git config complete"
