#!/bin/bash
echo $HOME
sudo mkdir /home/jj
sudo mkdir /home/jj/www
sudo mkdir /home/jj/www/share
sudo chown -R $USER:$USER /home/jj

# Node and NPM are not actually needed in this install since it is technically only serving static files
echo -e "\033[9;34m ## Running: curl nodejs12 source \033[m"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash

echo -e "\033[9;34m ## Running: sudo apt-get install nodejs \033[m"
sudo apt-get install nodejs

echo -e "\033[9;34m ## Running: mkdir ~/.npm-global \033[m"
mkdir home/jj/.npm-global

echo -e "\033[9;34m ## Running: npm config set prefix '/home/jj/.npm-global' \033[m"
npm config set prefix '/home/jj/.npm-global'

printf "#### \n SET NPM CONFIG \n ####\n"

echo -e "\033[9;34m ## Appending profile PATH to include .npm-global binaries '~/.npm-global' \033[m"
echo "export PATH=/home/jj/.npm-global/bin:$PATH" >> ~/.profile

#sudo apt-get install sqlite3
#sudo apt install tree
#sudo apt install tmux
echo -e "\033[9;34m ## Running: sudo apt update \033[m"
sudo apt update
echo -e "\033[9;34m ## Running: sudo apt install -y nginx \033[m"
sudo apt install -y nginx
echo -e "\033[9;34m ## Running: sudo apt install ufw \033[m"
sudo apt install ufw


echo -e "\033[1;35m ## Setting Up Firewall\033[m"
sudo ufw allow 'Nginx Full'
sudo ufw allow 'OpenSSH'
sudo ufw allow 22/tcp
sudo ufw enable
sudo ufw status

cd /home/jj

# Sanitize & Setup Environment
# ~~~~~~~~~~~~~~~~~~~~~~~~

# Remove default nginx configuration
echo -e "\033[1;35m ## Removing Default Nginx Configuration Files\033[m"
sudo rm /etc/nginx/nginx.conf
sudo rm -rf /etc/nginx/sites-enabled
sudo rm -rf /etc/nginx/sites-available
sudo rm /etc/nginx/conf.d/default.conf

echo -e "\033[1;35m ## Creating Share Files\033[m"
echo "hi kate" > /home/jj/www/share/kate.txt
echo "hi jj" > /home/jj/www/share/jj.txt


# Curl or Clone Git Repo
# ~~~~~~~~~~~~~~~~~~~~~~~~
echo -e "\033[1;35m ## Copying Config Files\033[m"
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
echo -e "\033[1;35m ## Setting Config File Ownership\033[m"
sudo chown $USER:$USER /etc/nginx/conf.d/default.conf
sudo chown $USER:$USER /etc/nginx/nginx.conf
sudo chown $USER:$USER /etc/nginx/conf.d/subs.conf

# Setup Games
# ~~~~~~~~~~~~~~~~~~~~~~~~
# add games
cd /home/jj/www
echo -e "\033[1;35m ## Setting Up Games\033[m"
sudo git clone https://github.com/clementsjj/games.git
sudo chown -R $USER:$USER /home/jj/www/games
# Links already accounted for in index.html

alias reload="sudo systemctl reload nginx"
alias test="sudo nginx -t"
alias status="sudo systemctl status nginx"

echo -e "\033[1;35m ## Starting Nginx\033[m"
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl reload nginx
sudo systemctl status nginx

echo -e "\033[0;32mInstall Complete.\033[m"

