cd ~/Desktop

curl -O http://darwinports.opendarwin.org/downloads/DarwinPorts-1.2-10.4.dmg

hdiutil attach DarwinPorts-1.2-10.4.dmg

cd /Volumes/DarwinPorts-1.2/

sudo installer -pkg DarwinPorts-1.2.pkg -target "/"

hdiutil detach /Volumes/DarwinPorts-1.2/