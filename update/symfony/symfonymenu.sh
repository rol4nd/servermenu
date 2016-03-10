#!/usr/bin/env sh

if [ $(id -u) -ne 0 ]; then
   echo "This script must be run as root"
   exit;
fi
path=`pwd`;

themenu()
{
        echo "${LIGHTGRAY}";figlet "Symfony"
        echo " "
        echo " "
        echo " -- Symfony Consolenbefehle --"
        echo " "
        echo "1 = Weblink / CacheClear"
        echo " "
        echo "33 => php bin/console router:debug (Zeigt alle Routen an)"
        echo " "
        echo "99 => Symfonyupdate"
        echo " "
        echo "x => Ende"
        echo " "
        echo "Bitte eine Auswahl treffen und mit Enter bestaetigen"
        echo " "
        echo " "
}

setOwner()
{
        chown www-data:www-data $path/* -R

}

symfonyUpdate()
{
        composer selfupdate
        composer update
        setOwner
}

clearCache()
{
        php $path/bin/console ca:cl
        php $path/bin/console ca:cl --env=prod
    setOwner
}

routeDebuggen()
{
        php bin/console debug:router
}

while true
do

        themenu

        read answer
        clear
        case $answer in
                1) clearCache;;
                33) routeDebuggen;;
                99) symfonyUpdate;;
                x) break;;

        esac

done