#!/bin/bash

# Setup MySQL Db
# sudo mysql -u root
# > create database strapi;
# > create user dumbo@localhost identified by 'password';
# > grant all privileges on strapi.* to dumbo@localhost
# > flush privileges;
# > quit;


mkdir /home/jj/www/strapi
#yarn create strapi-app /home/jj/www/backend --quickstart --no-run
#yarn strapi install graphql
yarn create strapi-app /home/jj/www/strapi --no-run

# > Custom (manual settings)
# > ... fill out information for mysql db ...
# > enable ssl connection: no (?)


# In strapi/config/environments/developtment/database.json
# add the following into "options"
# "pool":{
#     "min":0,
#     "max":15,
#     "idleTimeoutMillis":30000,
#     "createTimeoutMillis":30000,
#     "acquireTimeoutMillis":30000
# }
#
yarn develop

# Since we opened port 1337, can access admin panel at admin.tsarchild.com:1337/admin
# if you click on the link from the default menu at admin.tsarchid.com, you will get redirected to localhost:1337/admin



#  Changed strapi.reverse.conf to look like this:
# map $http_x_forwarded_host $custom_forwarded_host {
#   default "$server_name";
#   strapi "strapi";
# }

# server {
#     listen 80;

#     server_name admin.tsarchild.com;

#     location = / {
#         proxy_pass http://strapi;
#         proxy_http_version 1.1;
# 		proxy_set_header X-Forwarded-Host $custom_forwarded_host;
#         proxy_set_header Upgrade $http_upgrade;
# 		proxy_set_header Host $http_host;
# 		proxy_set_header Connection "Upgrade";

# # Not sure about below..
# 		proxy_set_header X-Forwarded-Server $host;
#         proxy_set_header X-Real-IP $remote_addr;
#         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#         proxy_set_header X-Forwarded-Proto $scheme;

#         #proxy_cache_bypass $http_upgrade;
#     }
# }



# To Run Strapi, do one of the following:
# Make server.js
echo "const strapi = require('strapi'); strapi().start();" > /home/jj/www/strapi/server.js
yarn start

# --OR-- 

# cd /home/jj/www/strapi
# pm2 init
# echo "module.exports = {apps: [{name: 'app',script: 'npm',args: 'start',},],};" > ecosystem.config.js
# pm2 start ecosystem.config.js