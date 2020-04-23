#!/bin/bash
echo $HOME
sudo mkdir /home/jj
sudo mkdir /home/jj/www
sudo mkdir /home/jj/www/share
sudo chown -R $USER:$USER /home/jj


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

cd /home/jj

# Sanitize & Setup Environment
# ~~~~~~~~~~~~~~~~~~~~~~~~

# Remove default nginx configuration
sudo rm /etc/nginx/nginx.conf
sudo rm -rf /etc/nginx/sites-enabled
sudo rm -rf /etc/nginx/sites-available
sudo rm /etc/nginx/conf.d/default.conf

echo "hi kate" > /home/jj/www/share/kate.txt
echo "hi jj" > /home/jj/www/share/jj.txt


# Curl or Clone Git Repo
# ~~~~~~~~~~~~~~~~~~~~~~~~
echo -e "\033[1;35mCopying Config Files\033[m"

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
sudo git clone https://github.com/clementsjj/games.git
sudo chown -R $USER:$USER /home/jj/www/games
# Links already accounted for in index.html

alias reload="sudo systemctl reload nginx"
alias test="sudo nginx -t"
alias status="sudo systemctl status nginx"

sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl reload nginx
sudo systemctl status nginx

echo -e "\033[0;32mInstall Complete.\033[m"

