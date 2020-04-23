#!/bin/bash
# 34m=blue;32m=green;36m=cyan;35m=magenta;31m=red;

echo -e  
echo -e "\033[0;34m |\033[m${i}"


programs=(nginx htop tmux pm2)
notinstalled=()

for i in ${programs[@]}
do 
	echo -e "\033[0;34m |\033[m${i}"
	if [ `which $i` ]
	then 
		echo -e "\033[0;32m	-Already Installed.\033[m"
	else 
		echo -e "\033[9;31m	-Not Installed\033[m"
		notinstalled+=( $i )
		echo "Installing ${i}"
		

	fi
done

echo "Not Installed: ${#notinstalled[@]}"
if [ "${#notinstalled[@]}" -gt '0' ] 
then 
	echo "Not Installed:"
	for i in ${notinstalled[@]}
	do
		echo ${i}
	done
fi

# Node
programs=(node npm)
