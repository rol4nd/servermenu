#!/usr/bin/env bash

if [ "$(whoami)" != "root" ]; then
  SUDO=sudo
fi

/etc/init.d/apache2 stop

  cp $2/$3/$3.conf /etc/apache2/sites-available/$3.conf
  ln -s /etc/apache2/sites-available/$3.conf /etc/apache2/sites-enabled/$3.conf

cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.old
cp /etc/apache2/sites-available/default.conf /etc/apache2/sites-available/default.conf.old


rm /etc/apache2/sites-available/000-default.conf
rm /etc/apache2/sites-enabled/000-default.conf
rm /etc/apache2/sites-available/default.conf
rm /etc/apache2/sites-enabled/default.conf

/etc/init.d/apache2 start

bash $1
