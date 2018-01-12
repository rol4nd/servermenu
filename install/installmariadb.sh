#!/usr/bin/env bash

PASSWORD="Te3XtcH"
export DEBIAN_FRONTEND="noninteractive"
#debconf-set-selections <<< "mariadb-server mariadb-server/root_password password $PASSWORD"
#debconf-set-selections <<< "mariadb-server mariadb-server/root_password_again password $PASSWORD"

apt-get install -y mariadb-server python-mysqldb

mysql -u root -e "SET PASSWORD FOR root@'localhost' = PASSWORD(‘$PASSWORD’);"

bash $1