#!/bin/bash
#
# Sleep adds a slight delay to the script so it feels more user friendly.
# Don't forget to `chmod +x loader.sh`
# Then you can run it with `./loader.sh`
# Get a list of all your backups
​
# Set the volume level to 5 (for later).
sudo osascript -e "set Volume 5"
​
# Install Homebrew + Cask
tput setaf 1; echo 🦊 Installing Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
​
​
​
# Declare a string variable `pkgs` as an array. 
declare -a pkgs
# List of packages to import into array
pkgs=(wget git git-lifs brew-pip speedtest-cli youtube-dl balena-cli)
# Loop through all the packages
# $variable 
# "double quotes" will process the statement as a string
# >>>>>> @{} ----access various formats of various data ---
# @{str: 3} where 3 is index number. pkgs[@] to reference the array count.
​
for p in "${pkgs[@]}"; do
# Print Installing $p
tput setaf 1; echo 🦊 Installing $p
​
# Install package
brew install $p
done
​
# First try installing mas, if that fails, install mas-cli/tap/mas
brew install mas || brew install mas-cli/tap/mas
​
# Checks if they are signed in the the App Store. If not, it will open a window in the background and ask them to sign in.
# It then pauses for 1 second (for user experience)
# When they press a key, it runs this whilte loop until they do.
while mas account | grep -q 'Not signed in'; do
	open -a App\ Store.app -g
	read -n1 -r -p "🦊 You must be logged in to the App Store. Opening it now so you can do that." n1 key
	sleep 1s
​
# ends the while loop
done
​
# Disable macOS Gatekeeper so you can open applications from unidentified developers.
sudo spctl --master-disable
​
# Now that you're signed in, install the Mac Apps.
tput setaf 5; echo 🦊 Installing Mac App Store Apps: 
​
# Yes, you can do this below with a loop, but I like being able to see everything in one place.
​
# Declare string array variable
declare -a apps
# Add apps to array
apps=(824171161 824183456 1455174458 913724705 1081413713 661676740 \
    409183694 405399194 462058435 784801555 462062816 462054704 \
	1014850245 540348655 957810159  803453959 590386474 518156125 \
	518156125 1225570693 527675231 497799835)
​
# Loop through packages and install
for a in "${apps[@]}"; do
	tput setaf 1; echo 🦊 Installing $a
	brew install $a
done
​
# mas install 824171161 	# Affinity Designer
# mas install 824183456 	# Affinity Photo
# mas install 1455174458 	# CharMap
# mas install 913724705 	# Disk Care
# mas install 1081413713 	# GIF Brewery 3
# mas install 661676740 	# iGif Creator
# mas install 409183694 	# Keynote
# mas install 405399194 	# Kindle
# mas install 462058435 	# Microsoft Excel
# mas install 784801555 	# Microsoft OneNote
# mas install 462062816 	# Microsoft PowerPoint
# mas install 462054704 	# Microsoft Word 
# mas install 1014850245 	# Monit
# mas install 540348655 	# Monosnap 
# mas install 957810159 	# Raindrop.io for Safari
# mas install 803453959 	# Slack
# mas install 590386474 	# SyncTime
# mas install 518156125 	# Spectrum
# mas install 1225570693 	# Ulysses
# mas install 527675231 	# Voice Recorder 
# mas install 497799835 	# Xcode 
    
# Next, let's install our casks.
tput setaf 5; echo 🦊 Installing Homebrew casks:
#
# Declare a string variable `pkgs` as an array. 
declare -a casks
casks=(1password android-studio appdelete authy balenaetcher boostnote cloudapp dash firefox github gitkraken goofy google-chrome grammarly malwarebytes netnewswire onyx raindropio signal sketch spotify sublime-text teamviewer telegram termius thonny transmission transmit vlc vnc-viewer zoomus)
​
# List of packages to import into array
# Loop through all the packages
# $variable 
# "double quotes" will process the statement as a string
# >>>>>> @{} ----access various formats of various data ---
# @{str: 3} where 3 is index number. pkgs[@] to reference the array count.
​
for c in "${casks[@]}"; do
# Print Installing $p
tput setaf 1; echo 🦊 Installing $c
​
# Install package
brew cask install $c
done
### Install Non-Homebrew/Non-Appstore Applications to Desktop Folder
## SD Cloner
​tput setaf 5; echo 🦊 Downloading SD Cloner
# Download SD Clone
wget -P /Users/j/Desktop/first-install-downloads/ https://twocanoes-software-updates.s3.amazonaws.com/SDClone3.dmg # SD Cloner
# Mount dmg
hdiutil attach /Users/j/Desktop/first-install-downloads/SDClone3.dmg
# Install package
sudo installer -pkg "/Volumes/SD Clone/SD Clone.pkg" -target "/"
# Sleep for 5 and Unmount dmg
sleep 5
hdiutil detach "/Volumes/SD Clone"
​
## Shift
tput setaf 5; echo 🦊 Downloading Shift
# Download Shift
wget -P /Users/j/Desktop/first-install-downloads/ https://update.tryshift.com/download/version/3.7.2/osx_64.dmg # Shift
# Mount dmg
hdiutil attach /Users/j/Desktop/first-install-downloads/osx_64.dmg
# Copy app file to Applications folder
sudo cp /Volumes/Shift/Shift.app /Applications
# Sleep for 5 and Unmount dmg
sleep 5
hdiutil detach /Volumes/Shift
​
## Blue Sherpa
tput setaf 5; echo 🦊 Downloading Blue Sherpa Microphone
wget -P /Users/j/Desktop/first-install-downloads/ http://software.bluedesigns.com/blue/BlueSherpa-20190312.pkg # Blue Sherpa
# Install package
sudo installer -pkg /Users/j/Desktop/first-install-downloads/BlueSherpa-20190312.pkg -target "/"
​
## Sonos
tput setaf 5; echo 🦊 Downloading Sonos
wget -P /Users/j/Desktop/first-install-downloads/ http://update.sonos.com/software/mac/mdcr/SonosDesktopController102.dmg # Sonos
# Mount dmg
hdiutil attach /Users/j/Desktop/first-install-downloads/SonosDesktopController102.dmg
# Copy app file to Applications folder
sudo cp /Volumes/Sonos/Sonos.app /Applications
# Sleep for 5 and Unmount dmg
sleep 5
hdiutil detach /Volumes/Sonos
​
​
# install Oh My Zsh
tput setaf 5; echo 🦊 Installing Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"