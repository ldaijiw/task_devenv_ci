#!/bin/bash

# Update the sources list
sudo apt-get update -y

# upgrade any packages available
# sudo apt-get upgrade -y

# set environment variable for DB_HOST
echo "export DB_HOST=192.168.10.200" >> ~/.bashrc

# install git
sudo apt-get install git -y

# install nodejs
sudo apt-get install python-software-properties -y
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y

# install pm2
sudo npm install pm2 -g

sudo apt-get install nginx -y

# unlink default config file
sudo unlink /etc/nginx/sites-enabled/default

# move custom config file to correct dir
sudo cp /home/ubuntu/nginx_config/proxy_config.conf /etc/nginx/sites-available/proxy_config.conf

# link the new proxy 
sudo ln -s /etc/nginx/sites-available/proxy_config.conf /etc/nginx/sites-enabled/proxy_config.conf


# finally, restart the nginx service so the new config takes hold

sudo systemctl restart nginx.service

cd /home/ubuntu/app

sudo npm install

pm2 start app.js --update-env