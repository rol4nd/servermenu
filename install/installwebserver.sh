#!/usr/bin/env bash

if [ "$(whoami)" != "root" ]; then
  SUDO=sudo
fi

echo "Install apache"

apt-get -y -qq install apache2
apt-get install -y python-certbot-apache

${sudo} service apache2 restart

echo "Install PHP"

#mariaDB-Client
apt-get install -y mariadb-client
apt-get install -y apt-transport-https

${sudo} apt -y install lsb-release apt-transport-https ca-certificates
${sudo} wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | ${sudo} tee /etc/apt/sources.list.d/php.list
${sudo} apt update

${sudo} apt -y install php7.4
${SUDO} apt-get -y install php7.4-cli php7.4-fpm php7.4-json php7.4-pdo php7.4-mysql php7.4-zip php7.4-gd
${sudo} apt-get -y install php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath php7.4-json php7.4-curl php7.4-intl

${sudo} apt-get -y install php-xdebug php-apcu

${sudo} service apache2 restart

${sudo} a2enmod rewrite

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

bash $1
