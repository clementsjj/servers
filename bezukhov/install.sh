#!/bin/bash
# 34m=blue;32m=green;36m=cyan;35m=magenta;31m=red; 

# Arrays
programs=(nginx htop tmux ufw git wget yarn sqlite3 mysql-server php)
notinstalled=()
npmpackages=(pm2 npx gatsby)
npmnotinstalled=()

echo "Beginning Installation..."
echo -e "\033[9;34m ## BLUE \033[m Command"
echo -e "\033[9;35m ## Magenta \033[m Description"


# Setup directory home for server files
echo -e "\033[9;35m ## Setting Up Environment \033[m"
rm -rf Desktop/ Documents/ Downloads/ Music/ Pictures/ Public/ Templates/ Videos/
sudo mkdir /home/jj
sudo mkdir /home/jj/www
sudo mkdir /home/jj/www/share
sudo mkdir /home/jj/www/backend
sudo chown -R $USER:$USER /home/jj

echo -e "\033[9;35m ## Updating apt \033[m"
sudo apt -q update
echo -e "\033[9;35m ## Upgrading apt \033[m"
sudo apt -q upgrade

##############################
# Install Nodejs v12(includes NPM)
##############################
echo -e "\033[9;35m ## Checking Node\033[m"
if [ `which node` ]
then
	echo "Node exists. Checking Version..."
	nodeversion=$(node --version)
	echo "Currently running Node ${nodeversion}"
	if [[ ${nodeversion} = v12* ]] 
	then 
		echo -e "\033[32mNode v12 Installed. Continuing Setup.\033[m"
	else
		echo -e "\033[31mNode v12 Not Installed. You are currently on ${nodeversion}. Installing v12 Now.\033[m"
		echo -e "\033[9;34m ## Running: curl nodejs12 source \033[m"
		curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash
		echo -e "\033[9;34m ## Running: sudo apt-get install nodejs \033[m"
		sudo apt-get -q install nodejs
	fi
else
	echo -e "\033[0;32m	Nodejs Not Installed. Installing Node v12 Now.\033[m"
	echo -e "\033[9;34m ## Running: curl nodejs12 source \033[m"
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash
	echo -e "\033[9;34m ## Running: sudo apt-get install nodejs \033[m"
	sudo apt-get -q install nodejs
fi

echo -e "\033[9;35m ## Setting global npm package directory\033[m"
echo -e "\033[9;34m ## Running: mkdir ~/.npm-global \033[m"
mkdir /home/jj/.npm-global
echo -e "\033[9;34m ## Running: npm config set prefix '/home/jj/.npm-global' \033[m"
npm config set prefix '/home/jj/.npm-global'

echo -e "\033[9;35m ## Checking Packages \033[m"

##############################
# Install Linux Packages
##############################
for i in ${programs[@]}
do 
	echo -e "\033[0;34m |\033[m${i}"
	if [ `which $i` ]
	then 
		echo -e "\033[0;32m	-Already Installed.\033[m"
	else 
		echo -e "\033[9;31m	-Not Installed\033[m"
		notinstalled+=( $i )
	fi
done

echo -e "Packages to install: ${notinstalled[@]}"
for i in ${notinstalled[@]}
do
	echo -e "\033[9;35m ## Installing ${i}...\033[m"
	if [ $i = "yarn"]
	then
		curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
		echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
		sudo apt update
		sudo apt -q install yarn
	elif [ $i = "php" ]
	then
		sudo apt install php-fpm
	else
		sudo apt -q install -y ${i}
	fi
done

#######################
# Install NPM packages
#######################
echo -e "\033[9;35m ## Install npm packages: npx, gatsby-cli, pm2 \033[m"
for i in ${npmpackages[@]}
do 
	echo -e "\033[0;34m |\033[m${i}"
	if [ `which $i` ]
	then 
		echo -e "\033[0;32m	-Already Installed.\033[m"
	else 
		echo -e "\033[9;31m	-Not Installed\033[m"
		npmnotinstalled+=( $i )
	fi
done

for i in ${npmnotinstalled[@]}
do
	echo -e "\033[9;35m ## Installing ${i}...\033[m"
	if [ $i = "pm2" ]
	then	
		wget -qO- https://getpm2.com/install.sh | bash
		pm2 install pm2-server-monit
	elif [ $i = "gatsby" ]
	then
		npm install -g gatsby-cli
	else
		npm install -g ${i}
	fi
done

#######################
# Setup Config Files
#######################
# Copy Config Files
echo -e "\033[35m ## Copying Config Files\033[m"
sudo curl -o /etc/nginx/nginx.conf https://raw.githubusercontent.com/clementsjj/servers/master/bezukhov/config/nginx.conf
sudo curl -o /etc/nginx/conf.d/default.conf https://raw.githubusercontent.com/clementsjj/servers/master/bezukhov/config/default.conf
sudo curl -o /etc/nginx/conf.d/nodereverse.conf https://raw.githubusercontent.com/clementsjj/servers/master/bezukhov/config/nodereverse.conf
sudo curl -o /home/jj/www/index.html https://raw.githubusercontent.com/clementsjj/servers/master/bezukhov/src/index.html
sudo curl -o /home/jj/nodeserver.js https://raw.githubusercontent.com/clementsjj/servers/master/bezukhov/src/nodeserver.js
sudo curl -o /home/jj/reset.sh https://raw.githubusercontent.com/clementsjj/servers/master/bezukhov/reset.sh
sudo curl -o /home/jj/.tmux.conf https://raw.githubusercontent.com/clementsjj/servers/master/bezukhov/config/.tmux.conf
sudo curl -o /etc/nginx/conf.d/strapi.reverse.conf https://raw.githubusercontent.com/clementsjj/servers/master/bezukhov/config/strapi.reverse.conf


############### Delete sites-available , sites-enabled
sudo rm -rf /etc/nginx/sites-available
sudo rm -rf /etc/nginx/sites-enabled

# Set Ownership
echo -e "\033[1;35m ## Setting Config File Ownership\033[m"
sudo chown -R $USER:$USER /etc/nginx/conf.d
sudo chown $USER:$USER /etc/nginx/nginx.conf
sudo chown $USER:$USER /home/jj/www/index.html

# Create share files
echo -e "\033[35m ## Creating Share\033[m"
echo "hi kate" > /home/jj/www/share/kate.txt
echo "hi jj" > /home/jj/www/share/jj.txt


#######################
# Setup Firewall
#######################
# Configure ufw
echo -e "\033[35m ## Configuring Firewall\033[m"
sudo ufw allow 'Nginx Full'
sudo ufw allow 'OpenSSH'
sudo ufw allow 22/tcp
sudo ufw allow 3000
sudo ufw allow 1337
sudo ufw enable
sudo ufw reload
sudo ufw status

#######################
# Setup MySQL
#######################
echo -e "\033[9;35m ## Setting up MySQL...\033[m"
sudo mysql_secure_installation

# Check status:
# systemctl status php7.2-fpm

#######################
# Setup .bashrc
#######################
#echo "PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u\033[01;34m\]@\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '" >> /home/jj/.bashrc

# Copy bashrc into .bak
mkdir /home/$USER/.bak
cp /home/$USER/.bashrc /home/$USER/.bak/.bashrc.bak 

# Set Aliases and path in bashrc
echo -e "\033[9;35m ## Setting .bashrc ##\033[m"
echo "alias test='sudo nginx -t'" >> /home/$USER/.bashrc
echo "alias status='sudo systemctl status nginx'" >> /home/$USER/.bashrc
echo "alias reload='sudo systemctl reload nginx'" >> /home/$USER/.bashrc
echo "alias nodestart='pm2 start /home/jj/www/nodeserver.js'" >> /home/$USER/.bashrc
echo "alias nodestop='pm2 stop /home/jj/www/nodeserver.js'" >> /home/$USER/.bashrc
echo "alias monit='pm2 monit'" >> /home/$USER/.bashrc
echo "export PATH=/home/jj/.npm-global/bin:$PATH" >> /home/$USER/.bashrc
source /home/$USER/.bashrc

#######################
# Launch Server
#######################
# launch nginx
echo -e "\033[1;35m ## Starting Nginx\033[m"
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl reload nginx
sudo systemctl status nginx

# launch node behind pm2
pm2 start /home/jj/nodeserver.js



echo -e "\033[9;35m ## SETUP COMPLETE ##\033[m"
echo "Run setupbackend.sh to setup Strapi"

