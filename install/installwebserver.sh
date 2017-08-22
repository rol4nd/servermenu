#!/usr/bin/env bash

apt-get install -y -qq proftpd

apt-get install -y -qq mysql-server mysql-client

apt-get install -y php7.0 php7.0-mysql php-xml php-fpm php-apcu php-memcache

apt-get install -y -qq apache2 apache2-mod-php7.0

#apt-get install -y -qq php5 libapache2-mod-php5

#apt-get install -y -qq php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt  php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl

#apt-get install php5-xcache

service apache2 restart


# DefaultRoot

OLD="# DefaultRoot"
NEW="DefaultRoot"

rpl "$OLD" "$NEW" /etc/proftpd/proftpd.conf

service proftpd restart

bash $1
