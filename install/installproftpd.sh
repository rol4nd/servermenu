#!/usr/bin/env bash

#proftpd
apt-get install -y -qq proftpd
useradd -o ftpuser -u 33 -g www-data -d /var/www/symfony -s /bin/bash
echo "ftpuser:F1leupl0ad" | chpasswd

bash $1