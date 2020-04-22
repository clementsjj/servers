#!/bin/bash
echo $HOME
printf "#####\nINSTALLING NODEJS\n#####"

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash
sudo apt-get install nodejs
mkdir ~/.npm-global
npm config set prfix '~/.npm-global'
printf "#### \n SET NPM CONFIG \n ####\n"
echo "export PATH=~/.npm-global/bin:$PATH" >> ~/.profile

sudo apt-get install sqlite3
sudo apt update
sudo apt install -y nginx

## ENSURE PORT 22 IS OPEN!
sudo ufw allow 'Nginx Full'
sudo ufw allow 'OpenSSH'
sudo ufw allow 22/tcp
sudo ufw enable
sudo ufw status
