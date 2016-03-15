#!/usr/bin/env bash

a2enmod rewrite

cp $1/symfony/symfony.conf /etc/apache2/sites-available/symfony.conf
ln -s /etc/apache2/sites-available/symfony.conf /etc/apache2/sites-enabled/symfony.conf
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.old

rm /etc/apache2/sites-available/000-default.conf
rm /etc/apache2/sites-enabled/000-default.conf

service apache2 restart

bash $1