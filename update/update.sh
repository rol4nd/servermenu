#!/usr/bin/env bash

apt update
apt -y upgrade
apt -y full-upgrade
apt -y autoremove
apt -y purge
apt autoclean

echo "Servermenu wird aktualisiert"

git pull origin master

bash $2/install/installbash.sh $1 $2

exec bash

bash $1
