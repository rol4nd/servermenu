#!/usr/bin/env bash

curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
chmod a+x /usr/local/bin/symfony

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

apt-get -y install php5-gd php5-mysql

bash $1
