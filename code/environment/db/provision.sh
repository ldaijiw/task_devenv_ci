# Installing mongodb 3.2.20 - Do it within VM
# Generate keys for mongo db

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# Installs the 3.2.20 version of mongoDB and starts
sudo apt update -y
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

# replace the original .conf file with the one that forces 0.0.0.0 port
sudo rm /etc/mongod.conf
sudo ln -s /home/ubuntu/environment/mongod.conf /etc/mongod.conf


# Can also -> sudo cp -f mongod.conf /etc/mongod.conf <- which overwrites the mongod.conf file


# if mongo is is set up correctly these will run it
sudo systemctl restart mongod
sudo systemctl enable mongod.service --now



# Can also do the below which is much faster and doesnt require writing .conf files
# sudo nano /etc/mongod.conf
# sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
# sudo service mongod restart


