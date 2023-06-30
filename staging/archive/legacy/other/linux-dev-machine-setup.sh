#!/bin/bash
# Update repository info
sudo apt update
# Initiate package updates
sudo apt upgrade
# Remove unneeded packages
sudo apt autoremove
# Install dependencies
sudo apt-get install -y build-essential curl wget git
# Download and run Node.js install script
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
# Install nodejs with apt
sudo apt install -y nodejs
# nodemon - Continuously run your server for dev purposes
sudo npm install -g nodemon
# create-react-app - Create React.js project template
sudo npm install -g create-react-app
# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y yarn
# Install Homebrew
# Download and run install script
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
# Add brew to your bash profile
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.bash_profile
# Install gcc
brew install gcc
# Install Hugo
brew install hugo
# Install tilix
sudo apt install -y tilix
# Install Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text
# Install Brave Browser
sudo apt install apt-transport-https curl
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser
# Install snaps
sudo snap install atom --classic
sudo snap install termius-app
sudo snap install spotify
sudo snap install slack --classic
sudo snap install code --classic
sudo snap install bitwarden
sudo snap install standard-notes
sudo snap install insomnia
