#!/bin/bash

#!/bin/bash
# 34m=blue;32m=green;36m=cyan;35m=magenta;31m=red; 
#echo -e "\033[0;34m |\033[m${i}"
echo "Beginning Installation..."
echo -e "\033[9;34m ## BLUE \033[m Command"
echo -e "\033[9;35m ## Magenta \033[m Description"


# Setup directory home for server files
echo -e "\033[9;35m ## Setting Up Environment \033[m"
rm -rf Desktop/ Documents/ Downloads/ Music/ Pictures/ Public/ Templates/ Videos/
sudo mkdir /home/jj
sudo mkdir /home/jj/www
sudo mkdir /home/jj/www/share
sudo chown -R $USER:$USER /home/jj

echo -e "\033[9;35m ## Updating apt \033[m"
sudo apt update
echo -e "\033[9;35m ## Upgrading apt \033[m"
sudo apt upgrade

# Install Nodejs(includes NPM), NPX
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
		sudo apt-get install nodejs
	fi
else
	echo -e "\033[0;32m	Nodejs Not Installed. Installing Node v12 Now.\033[m"
	echo -e "\033[9;34m ## Running: curl nodejs12 source \033[m"
	curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash
	echo -e "\033[9;34m ## Running: sudo apt-get install nodejs \033[m"
	sudo apt-get install nodejs
fi

echo -e "\033[9;35m ## Setting global npm package directory\033[m"
echo -e "\033[9;34m ## Running: mkdir ~/.npm-global \033[m"
mkdir /home/jj/.npm-global
echo -e "\033[9;34m ## Running: npm config set prefix '/home/jj/.npm-global' \033[m"
npm config set prefix '/home/jj/.npm-global'

echo -e "\033[9;35m ## Checking Packages \033[m"
programs=(nginx htop tmux pm2 ufw git)
notinstalled=()
# Install packages other than Nodejs(includes NPM), NPX
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

# Install packages that don't already exist.
# This needs to be run after nodejs installation iot install pm2 and npx
for i in ${notinstalled[@]}
do
	echo -e "\033[9;35m ## Installing ${i}...\033[m"
	if [ ${i} != pm2 ]
	then 
		sudo apt install -y ${i}
	else
		# Special pm2 install package
		echo "Installing pm2."
		npm install -g pm2
	fi
		
done

echo -e "\033[9;35m ## Install npx \033[m"
npm install -g npx








echo -e "\033[9;35m ## SETUP COMPLETE ##\033[m"


