three_shas=$(curl --silent https://www.raspberrypi.org/downloads/raspbian/ | grep 'SHA-256' | cut -c73-136)


# This creates three variables, each one is holding the most recent SHA-256
remote_buster_all=$(echo $three_shas | head -1 | tail -2)         # Raspbian Buster with desktop and recommended software
remote_buster_desktop=$(echo $three_shas | head -2 | tail -1)     # Raspbian Buster with desktop
remote_buster_lite=$(echo $three_shas | tail -1)                # Raspbian Buster Lite

remote_sha=$(echo $remote_buster_desktop)
# Calculate the SHA-256 Checksum downloaded from the same file.
local_sha="$(shasum -a 256 raspian_latest.zip)"

echo $remote_sha
echo $local_sha


# If they are the same, print that they are. If they are not, delete the file, and re-download it.
# Both variables need to be converted to strings, so "put them in quotes" and then  check
if [ $remote_sha == $local_sha ]; then
    tput setaf 5; echo 🦊 "The local version of the file is intact."
else
    tput setaf 5; echo 🦊 "Bad local version of the file. I'm deleting it."
    # sudo rm -rf raspian_latest.zip
    exit
fi