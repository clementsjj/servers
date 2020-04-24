#!/bin/bash
# 34m=blue;32m=green;36m=cyan;35m=magenta;31m=red; 
#echo -e "\033[0;34m |\033[m${i}"

# Setup directory home for server files
echo -e "\033[9;34m ## Setting Up Environment \033[m"
rm -rf Desktop/ Documents/ Downloads/ Music/ Pictures/ Public/ Templates/ Videos/
sudo mkdir /home/jj
sudo mkdir /home/jj/www
sudo mkdir /home/jj/www/share
sudo chown -R $USER:$USER /home/jj

echo -e "\033[9;34m ## Updating apt \033[m"
sudo apt update
echo -e "\033[9;34m ## Installing Packages \033[m"
programs=(nginx htop tmux pm2 ufw)
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
		echo "\033[9;34m ## Installing...\033[m"
		sudo apt install ${i}
	fi
done


# Install Nodejs(includes NPM), NPX
if [ `which node` ]
then
	nodeversion=$(node --version)
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

echo -e "\033[9;34m ## Running: mkdir ~/.npm-global \033[m"
mkdir /home/jj/.npm-global
echo -e "\033[9;34m ## Running: npm config set prfix '/home/jj/.npm-global' \033[m"
npm config set prefix '/home/jj/.npm-global'







# Print install stats
echo "Not Installed: ${#notinstalled[@]}"
if [ "${#notinstalled[@]}" -gt '0' ] 
then 
	echo "Not Installed:"
	for i in ${notinstalled[@]}
	do
		echo ${i}
	done
fi

# Set Aliases
echo "alias reload='sudo systemctl reload nginx'" >> /home/$USER/.bashrc
echo "alias start='sudo systemctl start nginx'" >> /home/$USER/.bashrc
echo "alias status='sudo systemctl status nginx'" >> /home/$USER/.bashrc
