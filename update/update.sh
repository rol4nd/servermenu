#!/usr/bin/env bash

#
apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y autoremove
apt-get -y purge
apt-get autoclean

echo "Servermenu wird aktualisiert"

git pull origin master

bash $2/install/installbash.sh $1 $2

exec bash

bash $1
