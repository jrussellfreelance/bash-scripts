
sudo apt-get install cifs-utils
sudo mkdir /home/jesse/data
sudo mount -t cifs -o user=jesse //192.168.0.101/data /home/jesse/data