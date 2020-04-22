#!/bin/bash

echo -e "Hey \033[1;32m WHAT UP \033[m guys"

programs=(nginx node npm htop tmux)
notinstalled=()

for i in ${programs[@]}
do 
	echo -e "\033[0;34m |\033[m${i}"
	if [ `which $i` ]
	then 
		echo -e "\033[0;32m	-Installed!\033[m"
	else 
		echo -e "\033[9;31m	-Not Installed\033[m"
		notinstalled+=( $i )
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
