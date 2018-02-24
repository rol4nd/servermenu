#!/usr/bin/env bash

echo "Install proFtpd"

#proftpd
apt-get install -y -qq proftpd
useradd -o ftpuser -u 33 -g www-data -d /var/www/symfony -s /bin/bash
echo "ftpuser:F1leupl0ad" | chpasswd

# DefaultRoot
OLD="# DefaultRoot"
NEW="DefaultRoot"

rpl "$OLD" "$NEW" /etc/proftpd/proftpd.conf

service proftpd restart

bash $1