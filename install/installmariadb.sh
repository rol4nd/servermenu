#!/usr/bin/env bash

PASSWORD="Te3XtcH"
export DEBIAN_FRONTEND="noninteractive"
sudo debconf-set-selections <<< "mariadb-server mariadb-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mariadb-server mariadb-server/root_password_again password $PASSWORD"

apt-get install -y mariadb-server python-mysqldb

bash $1