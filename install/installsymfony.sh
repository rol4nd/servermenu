#!/usr/bin/env bash

curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
chmod a+x /usr/local/bin/symfony

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer