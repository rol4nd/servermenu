#!/usr/bin/env bash

defaultfolder="/var/www"
projectname="symfony"

composer create-project symfony/skeleton "$defaultfolder/$projectname"

chown www-data:www-data $defaultfolder/* -R

bash $1