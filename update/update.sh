#!/usr/bin/env bash

#
apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y autoremove
apt-get -y purge
apt-get autoclean

git pull origin master

bash $DIR/install/installbash.sh $Startfile $DIR;;

bash $1
