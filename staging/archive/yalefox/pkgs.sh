# Declare string array variable
declare -a pkgs
# Add packages to array
pkgs=(wget git git-lifs brew-pip speedtest-cli youtube-dl balena-cli)

# Loop through packages and install
for p in "${pkgs[@]}"; do
tput setaf 1; echo 🦊 Installing $p
brew install $p
done