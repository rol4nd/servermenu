#!/usr/bin/env bash

apt-get install -y -qq proftpd

apt-get install -y -qq mariaDB-client

apt-get install -y php7.0 php7.0-mysql php-xml php-fpm php-apcu php-memcache php7.0-xml php-xdebug

apt-get install -y -qq apache2 apache2-mod-php7.0

service apache2 restart


# DefaultRoot

OLD="# DefaultRoot"
NEW="DefaultRoot"

rpl "$OLD" "$NEW" /etc/proftpd/proftpd.conf

service proftpd restart

bash $1
