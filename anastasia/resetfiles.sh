echo -e "\033[1;35m Resetting Files.\033[m"

filename="sites-available"
echo "Ressetting ${filename}"
mkdir /etc/nginx/$filename

filename="sites-enabled"
echo "Ressetting ${filename}"
mkdir /etc/nginx/$filename

filename="www"
echo "Resetting ${filename}"
mkdir /home/jj/${filename}

filename="share"
echo "Resetting ${filename}"
mkdir ~/${filename}

filename="nginx.conf"
echo "Resetting ${filename}"
curl -o /etc/nginx/nginx.conf https://raw.githubusercontent.com/clementsjj/servers/master/anastasia/config/nginx.conf

filename="default.conf"
echo "Resetting ${filename}"
curl -o /etc/nginx/conf.d/default.conf https://raw.githubusercontent.com/clementsjj/servers/master/anastasia/config/default.conf

filename="index.html"
echo "Resetting ${filename}"
curl -o ~/www/index.html https://raw.githubusercontent.com/clementsjj/servers/master/server/anastasia/config/nginx.conf



echo -e "\033[1;35m Reset Complete.\033[m"