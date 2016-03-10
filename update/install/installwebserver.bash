#!/usr/bin/env bash

source /opt/update/header.bash

echotext "Webserver wird installiert\n\n" "Gre"

apt-get install -y -qq proftpd

apt-get install -y -qq mysql-server mysql-client

apt-get install -y -qq apache2

apt-get install -y -qq php5 libapache2-mod-php5

apt-get install -y -qq php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl

apt-get install php5-xcache

service apache2 restart

bash $1