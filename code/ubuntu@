#!/bin/bash

# Update and upgrade any packages
sudo apt update
sudo apt upgrade

# Issues command to import MongoDB public GPG Key specifying 3.2
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -

# Create 3.2 list file for Ubuntu 18.04 (Bionic)
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Reload local package database
sudo apt update

# Install specific release version 3.2.20 with autoconfirmation
sudo apt install mongodb-org=3.2.20 -y

# To prevent accidental apt upgrades
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections


# Configure IP for MongoDB
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

# Start server
sudo systemctl start mongod

# Enable ensures that MongoDB will still start following a system reboot
sudo systemctl enable mongod