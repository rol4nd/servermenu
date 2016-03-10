#!/usr/bin/env bash


source /opt/update/header.bash

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

