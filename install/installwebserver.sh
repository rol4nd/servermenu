#!/usr/bin/env bash

#proftpd
apt-get install -y -qq proftpd
useradd -o ftpuser -u 33 -g www-data -d /var/www/symfony -s /bin/bash
echo "ftpuser:F1leupl0ad" | chpasswd

#mariaDB-Client
apt-get install -y -qq mariadb-client

#PHP 7.1
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/sury.list
apt-get install -y -qq apt-transport-https
curl https://packages.sury.org/php/apt.gpg | apt-key add -
apt-get update
apt-get install -y -qq php7.1
apt-get install -y -qq php7.1-xml
apt-get install -y -qq apache2

apt-get install -y python-certbot-apache

service apache2 restart


# DefaultRoot
OLD="# DefaultRoot"
NEW="DefaultRoot"

rpl "$OLD" "$NEW" /etc/proftpd/proftpd.conf

service proftpd restart

bash $1
