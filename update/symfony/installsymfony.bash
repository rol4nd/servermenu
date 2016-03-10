#!/usr/bin/env bash


source /opt/update/header.bash


curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
chmod a+x /usr/local/bin/symfony

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer



askforfolder()
{
    echotext "In welchem Verzeichnis soll das Symfonymenü installiert werden?\n\n" "Gre"

    read -e answer

    if [ ! -f $answer/composer.json ]; then
        clear
        printf $answer
        echo -e "${Red}Verzeichnis konnte nicht gefunden werden${RCol}"
    else
        rm $answer/symfonymenu.sh
        cp /opt/update/symfony/symfonymenu.sh $answer/.

        bash /opt/update/menu.bash
    fi

}

askforfolder

