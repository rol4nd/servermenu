#!/usr/bin/env bash

echo "Install apache"

sudo apt -y -qq install apache2
sudo apt install -y python-certbot-apache

sudo service apache2 restart

echo "Install PHP"

#mariaDB-Client
sudo apt install -y mariadb-client
sudo apt install -y apt-transport-https

sudo apt -y install lsb-release apt-transport-https ca-certificates
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list

sudo apt update

sudo apt -y install php7.4
sudo apt -y install php7.4-cli php7.4-fpm php7.4-json php7.4-pdo php7.4-mysql php7.4-zip php7.4-gd
sudo apt -y install php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath php7.4-json php7.4-curl php7.4-intl

sudo apt -y install php-xdebug php-apcu

sudo service apache2 restart

sudo a2enmod rewrite

sudo mkdir -p /usr/local/bin

sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

sudo curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
sudo chmod a+x /usr/local/bin/symfony
bash $1
