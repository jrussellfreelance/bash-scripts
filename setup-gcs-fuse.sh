# This script installs Google Cloud SDK and GCS Fuse so you can mount buckets as folders to your server
mkdir ~/apps && cd ~/apps
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-156.0.0-linux-x86_64.tar.gz
tar xvzf google-cloud-sdk-156.0.0-linux-x86_64.tar.gz
rm -rf google-cloud-sdk-156.0.0-linux-x86_64.tar.gz
./google-cloud-sdk/install.sh
source ~/.bashrc
gcloud auth login
gcloud auth application-default login
sudo touch /etc/apt/sources.list.d/gcsfuse.list
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install gcsfuse