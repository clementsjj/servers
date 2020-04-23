#35m = Magenta | 36m = Cyan | 34m = Blue  | 32m = Green
#echo -e "\033[1;35m  \033[m"

filesremoved=()

echo -e "\033[1;35m Sanitizing Environment \033[m"


filename="sites-available"
if [ -d "/etc/nginx/${filename}" ]
then 
	echo -e "Removing ${filename} directory"
	rm -rf /etc/nginx/sites-available
	filesremoved+=( $filename )
else 
	echo -e "\033[1;31m${filename} does not exist.\033[m"
fi
filename="sites-enabled"
if [ -d "/etc/nginx/${filename}" ]
then 
	echo -e "Removing ${filename} directory"
	rm -rf /etc/nginx/${filename}
	filesremoved+=( $filename )
else 
	echo -e "\033[1;31m${filename} does not exist\033[m"
fi
filename="nginx.conf"
if [ -w "/etc/nginx/${filename}" ]
then 
	echo -e "Removing ${filename}"
	rm -rf /etc/nginx/${filename}
	filesremoved+=( $filename )
else 
	echo -e "\033[1;31m${filename} does not exist\033[m"
fi
filename="conf.d"
if [ -d "/etc/nginx/${filename}" ]
then 
	echo -e "Removing ${filename}"
	rm -rf /etc/nginx/${filename}
	mkdir /etc/nginx/conf.d
	filesremoved+=( $filename )
else 
	echo -e "\033[1;31m${filename} does not exist\033[m"
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
	echo -e "\033[1;31m${filename} does not exist\033[m"
fi
filename="share"
if [ -d "/home/jj/${filename}" ]
then 
	echo -e "Removing ${filename}"
	rm -rf ~/${filename}
	filesremoved+=( $filename )
else 
	echo -e "\033[1;31m${filename} does not exist\033[m"
fi


#####################################
# Place printf Table Here -- Removed Files**
if [ "${#filesremoved[@]}" -gt '0' ] 
then 
	echo "Files Removed:"
	for i in ${filesremoved[@]}
	do
		echo -e "\033[1;32m${i}\033[m"
	done
else 
	echo "No files removed."
fi





echo -e "\033[1;35mSanitization Complete\033[m"