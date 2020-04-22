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

sudo ufw allow 'Nginx Full'
sudo ufw allow 'OpenSSH'
sudo ufw allow 22/tcp
sudo ufw enable
sudo ufw status

cd ~
rm -rf ~/strapsby
sleep 1
git clone https://github.com/clementsjj/strapsby.git
sleep 1

# Remove default nginx configuration
sudo rm /etc/nginx/nginx.conf
sudo rm -rf /etc/nginx/sites-enabled
sudo rm -rf /etc/nginx/sites-available

mkdir ~/www
mkdir ~/share

# There is some problem here running the original code that copies the files from the git clone
# Not sure why I'm getting the error
# But curling the file from the actual github repo seems to work fine for now
# Seeing as I am already cloning the github repo, itd be nice to use those files
# Possibly a sudo issue??
# ~~~~~~~~~~~~~~~~~~~~~~~~
sudo curl -o /etc/nginx/nginx.conf https://raw.githubusercontent.com/clementsjj/strapsby/master/server/anastasia/config/nginx.conf
sudo curl -o /etc/nginx/conf.d/default.conf https://raw.githubusercontent.com/clementsjj/strapsby/master/server/anastasia/config/default.conf
sudo curl -o ~/www/index.html https://raw.githubusercontent.com/clementsjj/strapsby/master/server/anastasia/config/index.html
# ~~~~~~~~~~~~~~~~~~~~~~~~

