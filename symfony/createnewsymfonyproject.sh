#!/usr/bin/env bash

defaultfolder="/var/www"
projectname="symfony"

composer selfupdate
composer create-project symfony/skeleton "$defaultfolder/$projectname"

chown www-data:www-data $defaultfolder/* -R

#Create Database and User
# create random password
PASSWDDB="Te3XtcH"

# replace "-" with "_" for database username
MAINDB="symfony"

# If /root/.my.cnf exists then it won't ask for root password
if [ -f /root/.my.cnf ]; then

    mysql -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    mysql -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"

# If /root/.my.cnf doesn't exist then it'll ask for root password
else
    echo "Please enter root user MySQL password!"
    read $PASSWDDB
    mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    mysql -uroot -p${rootpasswd} -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
    mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
    mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
fi

#composercomponents
composer require twig annotations symfony/apache-pack mailer doctrine maker
composer requrire --dev profiler

cp $2/symfony/htaccess.example $defaultfolder/$projectname/public/.htaccess

chown www-data:www-data $defaultfolder/$projectname/* -R

bash $1