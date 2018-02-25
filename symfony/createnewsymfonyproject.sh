#!/usr/bin/env bash

defaultfolder="/var/www"
projectname="symfony"

composer selfupdate
cd "$defaultfolder"
composer create-project symfony/skeleton "$projectname"
#cd "$projectname"
#composer require symfony/apache-pack

#Create Database and User
# create random password
PASSWDDB="Te3XtcH"

# replace "-" with "_" for database username
MAINDB="symfony"

#echo "/n/rDATABASE_URL='mysql://$MAINDB:$PASSWDDB@127.0.0.1:3306/$projectname'" >> $defaultfolder/$projectname/.env
chown www-data:www-data $defaultfolder/$projectname/* -R

bash $1