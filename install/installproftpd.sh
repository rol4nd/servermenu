#!/usr/bin/env bash

echo "Install proFtpd"

#proftpd
apt-get install -y -qq proftpd
chown www-data:www-data /var/www -R
useradd -o ftpuser -u 33 -g www-data -d /var/www -s /bin/bash

echo "ftpuser:F1leupl0ad" | chpasswd


# DefaultRoot
OLD="# DefaultRoot"
NEW="DefaultRoot"

rpl "$OLD" "$NEW" /etc/proftpd/proftpd.conf

service proftpd restart

bash $1
