#!/usr/bin/env bash

echo "Install PHP"

#mariaDB-Client
apt-get install -y mariadb-client
apt-get install -y apt-transport-https

checkInstallApache() {
  type apache2 >/dev/null 2>&1 || apt-get -y -qq install apache2
  apt-get install -y python-certbot-apache
}

if [ $3 == "7.3" ]; then
  #PHP 7.4
  if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
  fi

  ${SUDO} apt-get -y install apt-transport-https lsb-release ca-certificates
  ${SUDO} wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
  ${SUDO} sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
  ${SUDO} apt-get update

  ${SUDO} apt-get -y install php7.3
  ${SUDO} apt-get -y install php7.3-cli php7.3-fpm php7.3-json php7.3-pdo php7.3-mysql php7.3-zip php7.3-gd php7.3-mbstring php7.3-curl php7.3-xml php7.3-bcmath php7.3-json php7.3-curl
  ${SUDO} apt-get -y install libapache2-mod-php7.3

elif [ $3 == "7.4" ]; then
  #PHP 7.4
  if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
  fi
  ${sudo} apt -y install lsb-release apt-transport-https ca-certificates
  ${sudo} wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | ${sudo} tee /etc/apt/sources.list.d/php.list
  ${sudo} apt update

  ${sudo} apt -y install php7.4
  ${SUDO} apt-get -y install php7.4-cli php7.4-fpm php7.4-json php7.4-pdo php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath php7.4-json php7.4-curl
else
  echo "no value"
fi

sudo apt-get -y install php-xdebug php-apcu

service apache2 restart

bash $1
