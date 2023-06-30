
# loop thru grepped services and stop and disable
for svc in $(ls | grep perm); do sudo systemctl stop $svc && sudo systemctl disable $svc && sudo systemctl status $svc; done