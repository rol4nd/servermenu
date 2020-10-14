#!/usr/bin/env bash

defaultfolder="/var/www"

cd "$defaultfolder"
mkdir "$defaultfolder/contao/web"
cd "$defaultfolder/contao/web"
wget https://download.contao.org/contao-manager/stable/contao-manager.phar
mv contao-manager.phar contao-manager.phar.php

chown www-data:www-data $defaultfolder/* -R

bash $1