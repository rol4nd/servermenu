#!/usr/bin/env bash

    if [ "$(whoami)" != "root" ]; then
        SUDO=sudo
    fi

    ${SUDO} mkdir -p /usr/local/bin
    ${SUDO} curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
    ${SUDO} chmod a+x /usr/local/bin/symfony
bash $1
