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
sudo apt install tree
sudo apt install tmux
sudo apt update
sudo apt install -y nginx

sudo ufw allow 'Nginx Full'
sudo ufw allow 'OpenSSH'
sudo ufw allow 22/tcp
sudo ufw enable
sudo ufw status

cd ~
sleep 1

# Sanitize & Setup Environment
# ~~~~~~~~~~~~~~~~~~~~~~~~

# Remove default nginx configuration
sudo rm /etc/nginx/nginx.conf
sudo rm -rf /etc/nginx/sites-enabled
sudo rm -rf /etc/nginx/sites-available
sudo rm /etc/nginx/conf.d/default.conf

mkdir /home/jj
mkdir /home/jj/www
mkdir /home/jj/www/share
echo "hi kate" > /home/jj/www/share/kate.txt
echo "hi jj" > /home/jj/www/share/jj.txt


# Curl or Clone Git Repo
# ~~~~~~~~~~~~~~~~~~~~~~~~
echo -e "\033[1;35mCopying Config Files\033[m"
pwd
sudo curl -o /etc/nginx/nginx.conf https://raw.githubusercontent.com/clementsjj/servers/master/anastasia/config/nginx.conf
sudo curl -o /etc/nginx/conf.d/default.conf https://raw.githubusercontent.com/clementsjj/servers/master/anastasia/config/default.conf
sudo curl -o /home/jj/www/index.html https://raw.githubusercontent.com/clementsjj/servers/master/anastasia/config/index.html
sudo curl -o /etc/nginx/conf.d/subs.conf https://raw.githubusercontent.com/clementsjj/servers/master/anastasia/config/subs.conf
# ~~~~~~~~~~~~~~~~~~~~~~~~
# 'servers' should already be downloaded, which is the home of this install.sh file
#git clone https://github.com/clementsjj/servers.git
# cp -r servers/anastasia/config/index.html ~/www
# cp -r servers/anastasia/config/nginx.conf /etc/nginx
# cp -r servers/anastasia/config/subs.conf /etc/nginx/conf.d
# cp -r servers/anastasia/config/default.conf /etc/nginx/conf.d
# ~~~~~~~~~~~~~~~~~~~~~~~~
sudo chown $USER:$USER /etc/nginx/conf.d/default.conf
sudo chown $USER:$USER /etc/nginx/nginx.conf
sudo chown $USER:$USER /etc/nginx/conf.d/subs.conf

# Setup Games
# ~~~~~~~~~~~~~~~~~~~~~~~~
# add games
cd /home/jj/www
git clone https://github.com/clementsjj/games.git
# Links already accounted for in index.html

sudo systemctl start nginx

echo -e "\033[0;32mInstall Complete.\033[m"

