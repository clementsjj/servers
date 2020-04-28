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








# start strapi
yarn develop