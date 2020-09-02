#!/usr/bin/env bash

if [ "$(whoami)" != "root" ]; then
  SUDO=sudo
fi

if [ $(/etc/init.d/apache2 status | grep -v grep | grep 'Apache2 is running' | wc -l) > 0 ]
then
 ${sudo} service apache2 stop

  cp $2/$3/$3.conf /etc/apache2/sites-available/$3.conf
  ln -s /etc/apache2/sites-available/$3.conf /etc/apache2/sites-enabled/$3.conf

  cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.old
  cp /etc/apache2/sites-available/default.conf /etc/apache2/sites-available/default.conf.old


  rm /etc/apache2/sites-available/000-default.conf
  rm /etc/apache2/sites-enabled/000-default.conf
  rm /etc/apache2/sites-available/default.conf
  rm /etc/apache2/sites-enabled/default.conf

  ${sudo} service apache2 start

else
  echo "Apache is not installed"
fi


bash $1
