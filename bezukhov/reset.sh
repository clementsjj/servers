#!/bin/bash
#35m = Magenta | 36m = Cyan | 34m = Blue  | 32m = Green
#echo -e "\033[1;35m  \033[m"

filesremoved=()
packagesremoved=()

echo -e "\033[1;35m ## Sanitizing Environment \033[m"
echo #########################

echo -e "\033[35m ## Removing nginx config files. \033[m"
filename="sites-available"
if [ -d "/etc/nginx/${filename}" ]
then 
	echo -e "Removing ${filename} directory."
	sudo rm -rf /etc/nginx/sites-available
	filesremoved+=( $filename )
else 
	echo -e "${filename} does not exist."
fi

filename="sites-enabled"
if [ -d "/etc/nginx/${filename}" ]
then 
	echo -e "Removing ${filename} directory."
	sudo rm -rf /etc/nginx/${filename}
	filesremoved+=( $filename )
else 
	echo -e "${filename} does not exist."
fi

filename="nginx.conf"
if [ -w "/etc/nginx/${filename}" ]
then 
	echo -e "Removing ${filename}."
	sudo rm -rf /etc/nginx/${filename}
	filesremoved+=( $filename )
else 
	echo -e "${filename} does not exist."
fi
filename="conf.d"
if [ -d "/etc/nginx/${filename}" ]
then 
	echo -e "Removing ${filename}"
	sudo rm -rf /etc/nginx/${filename}
	filesremoved+=( $filename )
else 
	echo -e "${filename} does not exist"
fi

filename=".npm-global"
if [ -d "/home/jj/${filename}" ]
then 
	echo -e "Removing ${filename}"
	rm -rf /home/jj/${filename}
	filesremoved+=( $filename )
else 
	echo -e "${filename} does not exist."
fi

filename="www"
# For some reason, using ~ in the conditional will not be true,
# But using rm ~ works ok
# Perplexing...
if [ -d "/home/jj/${filename}" ]
then 
	echo -e "Removing ${filename}"
	rm -rf ~/${filename}
	filesremoved+=( $filename )
else 
	echo -e "${filename} does not exist."
fi


echo -e "\033[9;35m ## Removing tmux \033[m"
sudo apt remove -y tmux
packagesremoved+=( tmux )
echo -e "\033[9;35m ## Removing ufw \033[m"
sudo apt remove -y ufw 
packagesremoved+=( ufw )
echo -e "\033[9;35m ## Removing htop \033[m"
sudo apt remove -y htop
packagesremoved+=( htop )
echo -e "\033[9;35m ## Removing nginx \033[m"
sudo apt-get purge -y -q nginx nginx-common
packagesremoved+=( nginx )
echo -e "\033[9;35m ## Removing nodejs \033[m"
sudo apt-get purge -y nodejs
packagesremoved+=( nodejs )

echo -e "\033[9;35m ## Auto Removing Dependencies \033[m"
sudo apt-get autoremove
#####################################
# Place printf Table Here -- Removed Files**
echo -e "\033[35m ## SANITIZATION COMPLETE ##\033[m"

echo -e "\033[35m ## Files Removed: \033[m"
if [ "${#filesremoved[@]}" -gt '0' ] 
then 
	for i in ${filesremoved[@]}
	do
		echo -e "\033[1;32m	-${i}\033[m"
	done
else 
	echo "No files removed."
fi

echo -e "\033[35m ## Packages Removed: \033[m"
if [ "${#packagesremoved[@]}" -gt '0' ] 
then 
	for i in ${packagesremoved[@]}
	do
		echo -e "\033[1;32m	-${i}\033[m"
	done
else 
	echo "No files removed."
fi



