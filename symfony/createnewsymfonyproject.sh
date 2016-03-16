#!/usr/bin/env bash

defaultfolder="/var/www"
projectname="symfony"

symfony new "$defaultfolder/$projectname"

cp $2/symfony/symfonymenu.sh $defaultfolder/$projectname/symfonymenu.sh

chown www-data:www-data $defaultfolder/* -R

useradd -o ftpuser -u 33 -g www-data -d /var/www/symfony -s /bin/bash
echo "ftpsymfony:F1leupl0ad" | chpasswd


bash $1