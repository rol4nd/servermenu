#!/usr/bin/env bash

echo "Install apache"

sudo apt -y -qq install apache2
sudo apt install -y python-certbot-apache

sudo service apache2 restart

echo "Install PHP"

#mariaDB-Client
sudo apt install -y mariadb-client
sudo apt install -y apt-transport-https

sudo apt install -y lsb-release apt-transport-https ca-certificates software-properties-common

echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -

sudo apt update

sudo apt install -y php8.0
sudo apt install -y php8.0-cli php8.0-fpm php8.0-json php8.0-pdo php8.0-mysql php8.0-zip php8.0-gd
sudo apt install -y php8.0-mbstring php8.0-curl php8.0-xml php8.0-bcmath php8.0-json php8.0-curl php8.0-intl

sudo apt install -y php-xdebug php-apcu

sudo service apache2 restart

sudo a2enmod rewrite

sudo mkdir -p /usr/local/bin

sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

sudo curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
sudo chmod a+x /usr/local/bin/symfony
bash $1
