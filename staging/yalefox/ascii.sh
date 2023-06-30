#!/bin/bash
reset # resets and clears the terminal when we run.
### LIST OF OUR FUNCTIONS ###
wait_for_space () {
# 	Here, we ask the terminal to wait for the user to press a key.
# 	If they press 'space' then we will continue with the script.
#	If they press any other key, it will exit.
#	This will let people quit
: '
read -s -n1 -r -p "Press 'space' to Continue, or any key to exit" key
while : ; do
    read -n 1 k <&1
if [[ $k = '' ]] ; then
​    break
else
​    exit
fi
done'
# Loop through read command and if statement until $key is not ann empty string
while [[ -z "$key" ]]
do
    # read for space or other character
    read -s -n1 -r -p "Press 'space' to Continue, or any key to exit" key
    # if $key is a space, break while loop and continue
    if [[ $key = '' ]] ; then
        break
    # if $key is anything else, exit script
    else
        exit
    fi
done
}
##############################
tput setaf 6; echo "

"
# Set terminal input to blue, print cloudflash logo and description
tput setaf 6; echo "
 ██████╗██╗      ██████╗ ██╗   ██╗██████╗ ███████╗██╗      █████╗ ███████╗██╗  ██╗
██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗██╔════╝██║     ██╔══██╗██╔════╝██║  ██║
██║     ██║     ██║   ██║██║   ██║██║  ██║█████╗  ██║     ███████║███████╗███████║
██║     ██║     ██║   ██║██║   ██║██║  ██║██╔══╝  ██║     ██╔══██║╚════██║██╔══██║
╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝██║     ███████╗██║  ██║███████║██║  ██║
 ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ 1.0"
# tput setaf changes the color of text in a terminal. Use `brackets` to change it mid-string
tput setaf 6; echo "⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ `tput setaf 5`http://www.yale.wtf/ `tput setaf 6`⋆⋆⋆⋆⋆⋆⋆⋆ `tput setaf 5`github.com/yalefox " 
tput setaf 6; echo "⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊 "
# More information about running scripts directly
tput setaf 2; echo "
  These are a series of user-friendly scripts that you can run from the cloud.
  This is controversial, because you can't see the code you are about to execute.
  Everything is open source, and I recommend copying it to your own private repo.
"
tput setaf 6; echo "⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊 "
# tput setaf changes the color of text in a terminal. Use `brackets` to change it mid-string
tput setaf 5; echo "
    This script flashes one or multiple SD cards with the latest Raspberry Pi.
"
tput setaf 6; echo "⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊 "
wait_for_space 		# Wait for them to continue or quit
clear 				# Clears the screen to continue
# Describes how the scripty works
tput setaf 2; echo "
██╗  ██╗ ██████╗ ██╗    ██╗    ██╗████████╗    ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗███████╗
██║  ██║██╔═══██╗██║    ██║    ██║╚══██╔══╝    ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔════╝
███████║██║   ██║██║ █╗ ██║    ██║   ██║       ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████╗
██╔══██║██║   ██║██║███╗██║    ██║   ██║       ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ╚════██║
██║  ██║╚██████╔╝╚███╔███╔╝    ██║   ██║       ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗███████║
╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝     ╚═╝   ╚═╝        ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝                                                                                      
 `tput setaf 5`»  Part I: 	`tput setaf 6` Check what the latest version of Raspian is.
 `tput setaf 5`»  Part II: 	`tput setaf 6` Download it, if we don't have it already.
 `tput setaf 5`»  Part III:	`tput setaf 6` Verify file integrity with SHA-256 Checksum.
 `tput setaf 5`»  Part IV: 	`tput setaf 6` Set mode to burn ONE or burn MULTIPLE.
 `tput setaf 5`»  Part V: 	`tput setaf 6` Automatically select the correct drive, have user confirm.
 `tput setaf 5`»  Part VI: 	`tput setaf 6` Burn Raspian to SD Card.
 `tput setaf 5`»  Part VI: 	`tput setaf 6` Burn Raspian to SD Card. 
"
# Press any key to continue, or X to exit.