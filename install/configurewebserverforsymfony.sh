#!/usr/bin/env bash

a2enmod rewrite
/etc/init.d/apache2 stop

cp $2/symfony/symfony.conf /etc/apache2/sites-available/symfony.conf
ln -s /etc/apache2/sites-available/symfony.conf /etc/apache2/sites-enabled/symfony.conf
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.old
cp /etc/apache2/sites-available/default.conf /etc/apache2/sites-available/default.conf.old

rm /etc/apache2/sites-available/000-default.conf
rm /etc/apache2/sites-enabled/000-default.conf
rm /etc/apache2/sites-available/default.conf
rm /etc/apache2/sites-enabled/default.conf

/etc/init.d/apache2 start
