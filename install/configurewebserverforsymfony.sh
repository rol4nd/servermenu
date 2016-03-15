#!/usr/bin/env bash

a2enmod rewrite

cp $1/symfony/symfony.conf /etc/apache2/site-available/symfony.conf
ln -s /etc/apache2/sites-available/symfony.conf /etc/apache2/sites-enabled/symfony.conf
cp /etc/apache2/sites-available/default.conf /etc/apache2/sites-available/default.conf.old

rm /etc/apache2/sites-available/default.conf
rm /etc/apache2/sites-enabled/default.conf

service apache2 restart

bash $1