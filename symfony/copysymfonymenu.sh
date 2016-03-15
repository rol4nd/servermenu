#!/usr/bin/env bash

defaultfolder="/var/www"
projectname="symfony"

cp $2/symfony/symfonymenu.sh $defaultfolder/$projectname/symfonymenu.sh

chown www-data:www-data $defaultfolder/$projectname/* -R

bash $1