#!/bin/bash

mkdir /home/jj/www/backend
yarn create strapi-app /home/jj/www/backend --quickstart --no-run
#yarn strapi install graphql
yarn develop