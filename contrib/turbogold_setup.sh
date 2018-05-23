#!/bin/bash
# This script will install all dependencies to run a StyleCoin (STY) Masternode.
# StyleCoin Repo : https://github.com/zero24x/stylecoin
# !! THIS SCRIPT NEED TO RUN AS ROOT !!
######################################################################
clear
echo "*********** Welcome to the StyleCoin (STY) Masternode Setup Script ***********"
echo 'This script will install all required updates & package for Ubuntu 14.04'
echo '****************************************************************************'
sleep 1
echo '*** Step 1/5 ***'
echo '*** Creating 3GB Swapfile ***'
sleep 1
fallocate -l 3G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo -e "/swapfile none swap sw 0 0 \n" >> /etc/fstab
sleep 1
echo '*** Done 1/5 ***'
sleep 1
echo '*** Step 2/5 ***'
echo '*** Running updates and install required packages ***'
sleep 1
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install git libgmp3-dev automake build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev libevent-dev nano -y
sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:bitcoin/bitcoin -y
sudo apt-get update -y
sudo apt-get install libdb4.8-dev -y
sudo apt-get install libdb4.8++-dev -y
sudo apt-get install libminiupnpc-dev -y
echo '*** Done 2/5 ***'
sleep 1
echo '*** Step 3/5 ***'
echo '*** Cloning and Compiling StyleCoin Wallet ***'
cd
git clone https://github.com/zero24x/stylecoin
cd stylecoin/src
make -f makefile.unix
mkdir ~/.StyleCoin
echo '*** Step 4/5 ***'
echo '*** Configure stylecoin.conf ***'
sleep 1
echo -n "Please Enter a username and Hit [ENTER]: "
read usrnam
echo -n "Please Enter a STRONG Password and Hit [ENTER]: "
read usrpas
echo -n "Please Enter your masternode genkey respond and Hit [ENTER]: "
read mngenkey
echo -n "Please Enter your VPS IP address respond and Hit [ENTER]: "
read vpsip
touch /root/.StyleCoin/StyleCoin.conf
echo -e "rpcuser=$usrnam \nrpcpassword=$usrpas \nrpcallowip=127.0.0.1 \nlisten=1 \nserver=1 \ndaemon=1 \nmasternode=1 \nlogtimestamps=1 \nmasternodeprivkey=$mngenkey \nexternalip=$vpsip:15802 \n" > /root/.StyleCoin/StyleCoin.conf
echo '*** Done 4/5 ***'
sleep 2
echo '*** Step 5/5 ***'
echo '*** Server Start and Wallet Sync ***'
./StyleCoind -daemon
sleep 1
echo 'Please wait for blockchain to sync before starting your alias, and enjoy your Masternode!'
sleep 1
echo '*** Done 5/5 ***'
