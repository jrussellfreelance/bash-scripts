#!/bin/bash
echo "Installing cifs-utils..."
sudo apt-get install -y cifs-utils
mkdir -p /home/jesse/data
sudo mount -t cifs -o user=jesse //192.168.0.101/data /home/jesse/data