#!/usr/bin/env bash

echo "Install PHP"

#mariaDB-Client
apt-get install -y mariadb-client

apt-get install -y apt-transport-https

checkInstallApache()
{
	type apache2 >/dev/null 2>&1 || apt-get -y -qq install apache2
	apt-get install -y python-certbot-apache
}

if [ $3 == "7.0" ]
then
	#PHP 7.0
	apt-get install -y php7.0 php7.0-mysql php7.0-xml
	checkInstallApache
	apt install apache2 libapache2-mod-php7.0
elif [ $3 == "7.1" ]
then
	#PHP 7.1
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/sury.list

	curl https://packages.sury.org/php/apt.gpg | apt-key add -
	apt-get update
	apt-get install -y php7.1 php7.1-xml
	checkInstallApache

elif [ $3 == "7.2" ]
then
	#PHP 7.2
	sudo apt-get -y install apt-transport-https lsb-release ca-certificates
	sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
	echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
	sudo apt-get update
	sudo apt-get -y install php7.2-cli php7.2-xml
	checkInstallApache
	sudo apt-get -y install libapache2-mod-php7.2
else
	echo "no value"
fi

sudo apt-get -y install php-xdebug php-apcu

service apache2 restart

bash $1