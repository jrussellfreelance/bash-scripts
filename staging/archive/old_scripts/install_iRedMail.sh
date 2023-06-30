read -p "FQDN hostname: " SERVERNAME
hostname $SERVERNAME
mkdir ~/apps && cd ~/apps/
wget https://bitbucket.org/zhb/iredmail/downloads/iRedMail-0.9.7.tar.bz2
tar xjf iRedMail-0.9.7.tar.bz2
rm -f iRedMail-0.9.7.tar.bz2
cd iRedMail-0.9.7/
sudo bash iRedMail.sh
