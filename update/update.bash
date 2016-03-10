#!/usr/bin/env bash


echotext "Es wird mit dem Systemupdate begonnen\n\n" "Gre"
apt-get update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y autoremove
apt-get -y purge
apt-get autoclean

bash $1
