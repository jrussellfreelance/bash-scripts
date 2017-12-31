echo "A MongoDB set up script"
echo "Adding repository..."
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
echo "Running apt-get update..."
sudo apt-get update
echo "Installing MongoDB..."
sudo apt-get install -y mongodb-org
echo "Starting and enabling mongod service..."
sudo systemctl start mongod
sudo systemctl status mongod
sudo systemctl enable mongod