#!/bin/bash
reset							# resets and clears the terminal when we run.
printf '\e[8;27;92t'            # This changes the size of the terminal so the script UI looks better.

##############################
#     tput setaf colors      #
# tput setaf 0 > black       #
# tput setaf 1 > red         #
# tput setaf 2 > green       #
# tput setaf 3 > yellow      #
# tput setaf 4 > blue        #
# tput setaf 5 > magenta     #
# tput setaf 6 > cyan        #
# tput setaf 7 > white       #
##############################
# Assign Color Variables
BLACK=0
RED=1
GREEN=2
YELLOW=3
BLUE=4
MAGENTA=5
CYAN=6
WHITE=7

# Set terminal input to blue, print cloudflash logo and description
tput setaf $CYAN; echo "
     ██████╗██╗      ██████╗ ██╗   ██╗██████╗ ███████╗██╗      █████╗ ███████╗██╗  ██╗
    ██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗██╔════╝██║     ██╔══██╗██╔════╝██║  ██║
    ██║     ██║     ██║   ██║██║   ██║██║  ██║█████╗  ██║     ███████║███████╗███████║
    ██║     ██║     ██║   ██║██║   ██║██║  ██║██╔══╝  ██║     ██╔══██║╚════██║██╔══██║
    ╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝██║     ███████╗██║  ██║███████║██║  ██║
     ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ 1.0"

# tput setaf changes the color of text in a terminal. Use `brackets` to change it mid-string
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"
tput setaf $MAGENTA; echo "			http://www.yale.wtf/ 		github.com/yalefox" 
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"
# More information about running scripts directly
tput setaf $GREEN; echo "  

    These are a part of a series of user-friendly scripts that you can run from the cloud.
             Follow the README.md in this repo for how to configure it properly.

"
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"

# tput setaf changes the color of text in a terminal. Use `brackets` to change it mid-string
tput setaf $MAGENTA; echo " 
    Cloudflash will download the latest version of Raspian in the format that you want.
      It will then burn one, or multiple SD cards with the correct Wifi Information.
"
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊
"
# 	Here, we ask the terminal to wait for the user to press a key.
# 	If they press 'space' then we will continue with the script.
#	If they press any other key, it will exit.
#	This will let people quit

# 	read will catch input from a terminal
# 	-s: 	silent mode (don't output text)
# 	-n1: 	the number of characters to read after
#	-p: 	display a prompt

tput setaf $GREEN; 											# Change the color to green

read -n1 -p "                       Press Y to continue, any other key to quit."  key

if [[ "$key" != "y" && "$key" != "Y" ]] ; then 	# If they press the 'y' key

	reset 					# Clear the screen
	echo "





				    Fine, I quit.




					" 	# Tell the user they've quit.
	exit 					# Quit the program

fi

clear 				# Clears the screen to continue

# Below will describe how the script works.

tput setaf $CYAN; echo "
 ██╗  ██╗ ██████╗ ██╗    ██╗    ██╗████████╗    ██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗███████╗
 ██║  ██║██╔═══██╗██║    ██║    ██║╚══██╔══╝    ██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝██╔════╝
 ███████║██║   ██║██║ █╗ ██║    ██║   ██║       ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ ███████╗
 ██╔══██║██║   ██║██║███╗██║    ██║   ██║       ██║███╗██║██║   ██║██╔══██╗██╔═██╗ ╚════██║
 ██║  ██║╚██████╔╝╚███╔███╔╝    ██║   ██║       ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗███████║
 ╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝     ╚═╝   ╚═╝        ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝"
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"
tput setaf $MAGENTA; echo "
                  The follow steps will happen after you run this script.
                  "
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"
tput setaf $GREEN; echo "


`tput setaf $MAGENTA`           »  Part I:   `tput setaf $CYAN`  Check what the latest version of Raspian is.
`tput setaf $MAGENTA`           »  Part I:   `tput setaf $CYAN`  Install homebrew, balena and other dependencies.
`tput setaf $MAGENTA`           »  Part II:  `tput setaf $CYAN`  Download latest version of Raspian & verify checksum.
`tput setaf $MAGENTA`           »  Part III: `tput setaf $CYAN`  Burn image to SD with Wi-Fi & SSH enabled.


"

# 	Here, we ask the terminal to wait for the user to press a key.
# 	If they press 'space' then we will continue with the script.
#	If they press any other key, it will exit.
#	This will let people quit

# 	read will catch input from a terminal
# 	-s: 	silent mode (don't output text)
# 	-n1: 	the number of characters to read after
#	-p: 	display a prompt

tput setaf $GREEN; 

read -n1 -p "                       Press Y to continue, any other key to quit."  key

if [[ "$key" != "y" && "$key" != "Y" ]] ; then	# If they press the 'y' key

	reset 					# Clear the screen
	echo "





				    Fine, I quit.




					" 	# Tell the user they've quit.
	exit 					# Quit the program
fi

clear 				# Clears the screen to continue

##############


####

# Test for empty choice variable
while [ -z "$CHOICE" ]; do
reset
# Prompt user for input
tput setaf $CYAN; echo "

		     ██████╗██╗  ██╗ ██████╗  ██████╗ ███████╗███████╗
		    ██╔════╝██║  ██║██╔═══██╗██╔═══██╗██╔════╝██╔════╝
		    ██║     ███████║██║   ██║██║   ██║███████╗█████╗  
		    ██║     ██╔══██║██║   ██║██║   ██║╚════██║██╔══╝  
		    ╚██████╗██║  ██║╚██████╔╝╚██████╔╝███████║███████╗
		     ╚═════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚══════╝╚══════╝
"
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"
tput setaf $MAGENTA; echo "          		  	 Select your options from below.                "
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"
tput setaf $GREEN; echo " 

`tput setaf $MAGENTA`           »  Press 1:     `tput setaf $CYAN`  Check that all dependencies are installed.

`tput setaf $MAGENTA`           »  Press 2:     `tput setaf $CYAN`  Download latest version of Raspian and verify checksum.
                                * Will not re-download if you already have it.

`tput setaf $MAGENTA`           »  Press 3:     `tput setaf $CYAN`  Burn an SD Card

`tput setaf $MAGENTA`           »  Press x: `tput setaf $CYAN`      Quit.

"
# Use the read command to capture the user's selection
read -n1 -p "           Enter your selection: " CHOICE

# Use a case statement to select the correct option, or exit the loop gracefully.
case $CHOICE in

  1) # Dependencies
    reset
# Set terminal input to blue, print cloudflash logo and description
tput setaf $CYAN; echo "
     ██████╗██╗      ██████╗ ██╗   ██╗██████╗ ███████╗██╗      █████╗ ███████╗██╗  ██╗
    ██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗██╔════╝██║     ██╔══██╗██╔════╝██║  ██║
    ██║     ██║     ██║   ██║██║   ██║██║  ██║█████╗  ██║     ███████║███████╗███████║
    ██║     ██║     ██║   ██║██║   ██║██║  ██║██╔══╝  ██║     ██╔══██║╚════██║██╔══██║
    ╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝██║     ███████╗██║  ██║███████║██║  ██║
     ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ 1.0"

# tput setaf changes the color of text in a terminal. Use `brackets` to change it mid-string
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"
tput setaf $MAGENTA; echo "                      Select your options from below.                "
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"
tput setaf $GREEN; echo " 
"

# Install Homebrew if not installed
if [[ -f "/usr/local/bin/brew" ]] ; then
    tput setaf $GREEN; echo -n "
    » Homebrew is already installed
    "
else
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" <<EOF
EOF
fi
# Install wget
    tput setaf $GREEN; echo -n "
    » Installing wget

    "
brew install wget
# Install balena CLI
	tput setaf $GREEN; echo -n "
    » Installing Balena CLI

	"
brew install balena-cli
# Install or reinstall nodejs
    tput setaf $GREEN; echo -n "
    » Installing NodeJS.

    "
# This command with an if statement will tell you if a brew package is already installed
if brew ls --versions nodejs > /dev/null; then
  brew reinstall nodejs
  brew link --overwrite node
else
  brew install nodejs
fi
    ;;

  2) # Image Download
reset

# Set terminal input to blue, print cloudflash logo and description
tput setaf $CYAN; echo "
     ██████╗██╗      ██████╗ ██╗   ██╗██████╗ ███████╗██╗      █████╗ ███████╗██╗  ██╗
    ██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗██╔════╝██║     ██╔══██╗██╔════╝██║  ██║
    ██║     ██║     ██║   ██║██║   ██║██║  ██║█████╗  ██║     ███████║███████╗███████║
    ██║     ██║     ██║   ██║██║   ██║██║  ██║██╔══╝  ██║     ██╔══██║╚════██║██╔══██║
    ╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝██║     ███████╗██║  ██║███████║██║  ██║
     ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝ 1.0"

# tput setaf changes the color of text in a terminal. Use `brackets` to change it mid-string
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"
tput setaf $MAGENTA; echo "             http://www.yale.wtf/        github.com/yalefox" 
tput setaf $CYAN; echo "🦊 ⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆ 🦊"

# Here we print the three options for download from Raspian.
tput setaf $MAGENTA; echo "


`tput setaf $MAGENTA`       »  Press 1: `tput setaf $CYAN`  Raspbian Buster with desktop and recommended software.

`tput setaf $MAGENTA`       »  Press 2: `tput setaf $CYAN`  Raspbian Buster with desktop.

`tput setaf $MAGENTA`       »  Press 3: `tput setaf $CYAN`  Raspbian Buster Lite."


# Use a while loop to grab option number until valid
while [ -z "$SHA" ]; do
tput setaf $CYAN; read -n1 -p "

        » Enter the number of the version you want to download (x to exit): 
     " SHA

tput setaf $GREEN;
# Use a case statement to grab the correct download link and SHA-256 checksum
case $SHA in

#   ### SHA-256 Verification ###

#   <div class="image-details sha256"><span>SHA-256:</span> <strong>549da0fa9ed52a8d7c2d66cb06afac9fe856638b06d8f23df4e6b72e67ed4cea</strong></div>
#   <div class="image-details sha256"><span>SHA-256:</span> <strong>2c4067d59acf891b7aa1683cb1918da78d76d2552c02749148d175fa7f766842</strong></div>
#   <div class="image-details sha256"><span>SHA-256:</span> <strong>a50237c2f718bd8d806b96df5b9d2174ce8b789eda1f03434ed2213bbca6c6ff</strong></div>

#   First head::    Raspbian Buster with desktop and recommended software
#   Second head:    Raspbian Buster with desktop
#   Third head:     Raspbian Buster Lite

#   SHA-256 is 256 bytes long, which is 64 characters { 2 ^ 64 } 
#   So we want to take the string of terminal Str(73, 73+64)

#   When we cut it, it returns this:
#       549da0fa9ed52a8d7c2d66cb06afac9fe856638b06d8f23df4e6b72e67ed4cea
#       2c4067d59acf891b7aa1683cb1918da78d76d2552c02749148d175fa7f766842
#       a50237c2f718bd8d806b96df5b9d2174ce8b789eda1f03434ed2213bbca6c6ff
  1) 
    remote_buster=$(curl --silent https://www.raspberrypi.org/downloads/raspbian/ | grep 'SHA-256' | cut -c73-136 | head -1 | tail -2)       # Raspbian Buster with desktop and recommended software
    wget --continue --output-document=raspian_latest.zip https://downloads.raspberrypi.org/raspbian_full_latest
    ;;

  2) 
    remote_buster=$(curl --silent https://www.raspberrypi.org/downloads/raspbian/ | grep 'SHA-256' | cut -c73-136 | head -2 | tail -1)       # Raspbian Buster with desktop
    wget --continue --output-document=raspian_latest.zip https://downloads.raspberrypi.org/raspbian_latest
    ;;

  3) 
    remote_buster=$(curl --silent https://www.raspberrypi.org/downloads/raspbian/ | grep 'SHA-256' | cut -c73-136 | tail -1)                 # Raspbian Buster Lite
    wget --continue --output-document=raspian_latest.zip https://downloads.raspberrypi.org/raspbian_lite_latest
    ;;

  [xX]) 
    exit
    ;;
  
  *)
    tput setaf $BLUE; echo "

    💬 Please enter a valid choice.
    "
    unset SHA
    ;;
esac
done

# If raspian_latest.zip exists, perform checksum validation
if [[ -f "raspian_latest.zip" ]]; then
    tput setaf $BLUE; echo "
    💬 The file has been downloaded, now let's verify it.
    "
local_sha="$(shasum -a 256 raspian_latest.zip | cut -c1-64)"
remote_sha=$(echo $remote_buster)							# Where you pick the version you want.

# Calculate the SHA-256 Checksum downloaded from the same file. The output looks like 
# 2c4067d59acf891b7aa1683cb1918da78d76d2552c02749148d175fa7f766842  raspian_latest.zip
# So we cut the first 64 characters

# If they are the same, print that they are. If they are not, delete the file, and re-download it.
# Both variables need to be converted to strings, so "put them in quotes" and then  check
if [[ $remote_sha == $local_sha ]]; then
    tput setaf $BLUE; echo "
    💬 The local version of the file is intact."
else
    tput setaf $RED; echo "
    💬 The local version of the file is corrupt, so I'm deleting it."
    sudo rm -rf raspian_latest.zip
    break
fi
else
    tput setaf $RED; echo "
    💬 The file has not been downloaded"
fi
    ;;

  3)

    reset
tput setaf $CYAN; echo -n "

    ██████╗ ██╗ ██████╗██╗  ██╗      █████╗       ██████╗ ██████╗ ██╗██╗   ██╗███████╗   
    ██╔══██╗██║██╔════╝██║ ██╔╝     ██╔══██╗      ██╔══██╗██╔══██╗██║██║   ██║██╔════╝██╗
    ██████╔╝██║██║     █████╔╝█████╗███████║█████╗██║  ██║██████╔╝██║██║   ██║█████╗  ╚═╝
    ██╔═══╝ ██║██║     ██╔═██╗╚════╝██╔══██║╚════╝██║  ██║██╔══██╗██║╚██╗ ██╔╝██╔══╝  ██╗
    ██║     ██║╚██████╗██║  ██╗     ██║  ██║      ██████╔╝██║  ██║██║ ╚████╔╝ ███████╗╚═╝
    ╚═╝     ╚═╝ ╚═════╝╚═╝  ╚═╝     ╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚══════╝   
                                  
                    "
# Use grep and cut to filter for partitions from the diskutil command, outputting to a file named disks
diskutil list | grep -E '[0-9]:' | cut -c34- > disks
# Use grep to filter for disk entries from the diskutil command, and loop through the results
diskutil list | grep /dev/disk | while read -r line ; do
    # These variables grep the outputted disks file for disk data
    # Grab the disk path, i.e. /dev/disk1
    devdisk=$(echo $line | awk '{print $1}')
    # Grab the disk number by selecting last character: /dev/disk1 --> 1 
    diskid=${devdisk: -1}
    # Create disk identifier syntax string, like this: disk1
    disknum=$(echo $devdisk | cut -c 6-)
    # Use disknum variable to grep for size type, size as it is printed, and size rounded for math.
    sizetype=$(grep $disknum disks | head -1 | awk '{print $(NF-1)}')
    sizeog=$(grep $disknum disks | head -1 | awk '{print $(NF-2)}')
    size=$(grep $disknum disks | head -1 | awk '{print $(NF-2)}' | cut -d . -f 1 | tr -dc '[:alnum:]')
    # If the disk entry is internal, print as not flashable
    if [[ "$line" =~ .*internal.* ]] ; then
        # Create identifier
        identifier=$disknum"s2"
        # Use identifier to grab diskname
        diskname=$(grep $identifier disks | cut -c-23)
        tput setaf $RED; echo -n "
                    [-] $diskname ($sizeog $sizetype)
                    "
        # Continue to next while iteration
        continue
    fi
    # If disk entry is external or synthesized
    if [[ "$line" =~ .*external.* || "$line" =~ .*synthesized.* ]] ; then
        identifier=$disknum"s1"
        diskname=$(grep $identifier disks | cut -c-23)
        # If the disk type is TB, print as not flashable
        if [[ "$sizetype" == "TB" ]] ; then
            tput setaf $RED; echo -n "
                    [-] $diskname ($sizeog $sizetype)
                    "
            continue
        fi
        # If the disk type is GB and greater than 64, print as not flashable
        if [ "$sizetype" = "GB" ] && [ $size -gt 64 ] ; then
            tput setaf $RED; echo -n "
                    [-] $diskname ($sizeog $sizetype)
                    "
            continue
        fi
        # Otherwise print as flashable
        tput setaf $GREEN; echo -n "
                    [$diskid] $diskname ($sizeog $sizetype)
                    "
    fi
done
    # Ask for drive number until the user enters a key
while [ -z "$NUM" ]; do
    tput setaf $BLUE; read -n1 -p "
                    Enter a drive number to burn (x to exit): " NUM
    # Listen for user to cancel and use continue statement to skip
    if [[ "$NUM" =~ ^([xX])$ ]] ; then
        tput setaf $BLUE; echo -n "
                    🦊 Alright, exiting!
                    "
    continue
    else
    # Create /dev/disk# path based on number entered
    diskpath="/dev/disk"$(echo $NUM)
    # Grab the rest of the line with grep in diskutil
    diskdetails=$(diskutil list | grep $diskpath)
    # Create disk identifier syntax string, like this: disk1
    disknum=$(echo $diskpath | cut -c 6-)
    # Use disknum variable to grep for size type, size as it is printed, and size rounded for math.
    sizetype=$(grep $disknum disks | head -1 | awk '{print $(NF-1)}')
    sizeog=$(grep $disknum disks | head -1 | awk '{print $(NF-2)}')
    size=$(grep $disknum disks | head -1 | awk '{print $(NF-2)}' | cut -d . -f 1 | tr -dc '[:alnum:]')
    # If the disk entry is internal, show error
    if [[ "$diskdetails" =~ .*internal.* ]] ; then
        tput setaf $RED; echo -n "
                    🦊 You can not flash to an internal drive.
                    "
        unset NUM
        continue
    fi
    # If disk entry is external or synthesized
    if [[ "$diskdetails" =~ .*external.* || "$diskdetails" =~ .*synthesized.* ]] ; then
        # If disk entry size type is TB, throw an error
        if [[ "$sizetype" == "TB" ]] ; then
        tput setaf $RED; echo -n "
                    🦊 You can not flash this drive.
                    "
        unset NUM
        continue
        fi
        # If disk entry size type is GB and greater than 64, throw an error
        if [ "$sizetype" = "GB" ] && [ $size -gt 64 ] ; then
        tput setaf $RED; echo -n "
                    🦊 You can not flash this drive.
                    "
        unset NUM
        continue
        fi
        # Otherwise
        # Use diskutil again to test if it is a legit disk
        if diskutil list | grep -q "$diskpath"; then
            tput setaf $BLUE; echo -n "
                        🦊 Alright, let's burn!
        "
        # Prompt for Wifi SSID and PSK
        while [[ -z "$SSID" ]]
        do
            read -p "
                        🦊 Wifi SSID: " SSID
        done
        while [[ -z "$PSK" ]]
        do
            read -s -p "
                        🦊 Wifi PSK:  " PSK
        done
        # Run this whole section as sudo so it only prompts for a password once.
        # We are dynamically adding the values of $diskpath, $SSID, and $PSK
        # In this section we are:
        # - using balena-cli to flash the image
        # - enabling SSH
        # - creating wifi settings file
        # - ejecting the disk
        sudo -- sh -c "
        balena local flash raspian_latest.zip --drive $diskpath --yes
            tput setaf $BLUE; echo -n '
                        🦊 SD Card flashed and verified succesfully.
        '
        touch /Volumes/boot/ssh
        tput setaf $BLUE; echo -n '
                        🦊 SSH enabled
        '
        echo 'country=US
        ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
        update_config=1

        network={
            ssid=\"$SSID\"
            psk=\"$PSK\"
        }' > /Volumes/boot/wpa_supplicant.conf
        tput setaf $BLUE; echo -n '
                        🦊 WiFi Settings Copied to SD Card
        '
        diskutil eject $diskpath --force > /dev/null
        "
        tput setaf $BLUE; echo -n "
                        🦊 Disk ejected
        "
        # Prompt the user for any key to continue
        read -n 1 -s -r -p "
                        🦊 Pi is written! Press any key to continue...
        "
        # If the drive number is not valid, prompt again
        else
            tput setaf $RED; echo -n "
                        🦊 Please enter a valid drive number.
        "
            unset NUM
        fi
    fi
    fi
done
# Clean up the disks file
rm -f disks
    ;;
    # Listen for exit key, which is x or X
  [xX]) 
    reset
    echo -n "





                    Bye!




                    "

	exit

    ;;
  # Reject all other input
  *) echo '
                    Please select an option.' >&2

esac

# Clear choice variable for next run
unset CHOICE
# Pause terminal for 5 seconds to view output ###### Mostly here to slow script down.
sleep 5
# Clear terminal to maintain formatting
clear

done