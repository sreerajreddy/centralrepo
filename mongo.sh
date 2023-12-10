#!/bin/bash

# Setting up MongoDB v5.0 


#update the packages
sudo apt update

#Installing MongoDB public gpg key
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/mongodb-archive-keyring.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

# Update package list
sudo apt-get update

# Install MongoDB
sudo apt-get install -y mongodb-org

# Start MongoDB
sudo systemctl start mongod

# Enable MongoDB 
sudo systemctl enable mongod


################################################

################################################


#Setting up the replica set and other configurations


#!/bin/bash


# Replica set name
rs="rs0"

# Port numbers for the members
P1=27017
P2=27018
P3=27019

# MongoDB data directory
DATA_DIR="/data/db"

# WiredTiger cache size (1GB)
CACHE_SIZE="1"
# Path to MongoDB binaries
MONGO_PATH="/usr/local/bin"

# Start MongoDB replica set members
$MONGO_PATH/mongod --port $PORT1 --dbpath $DATA_DIR/$P1 --replSet $rs --wiredTigerCacheSizeGB $CACHE_SIZE --setParameter disableJavaScriptProtection=true &
$MONGO_PATH/mongod --port $PORT2 --dbpath $DATA_DIR/$P2 --replSet $rs --wiredTigerCacheSizeGB $CACHE_SIZE --setParameter disableJavaScriptProtection=true &
$MONGO_PATH/mongod --port $PORT3 --dbpath $DATA_DIR/$P3 --replSet $rs --wiredTigerCacheSizeGB $CACHE_SIZE --setParameter disableJavaScriptProtection=true --arbiter &

# Wait for MongoDB instances to start
sleep 20


