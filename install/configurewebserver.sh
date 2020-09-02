#!/usr/bin/env bash

 sudo service apache2 stop

  cp $2/$3/$3.conf /etc/apache2/sites-available/$3.conf
  ln -s /etc/apache2/sites-available/$3.conf /etc/apache2/sites-enabled/$3.conf

  mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.old
  rm /etc/apache2/sites-enabled/000-default.conf

  sudo service apache2 start


bash $1
