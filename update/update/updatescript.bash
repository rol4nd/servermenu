#!/bin/bash


echotext()
{
        echo -e "${!2}$1${RCol}"
}

echospaceline()
{
        for((i=0;i<$1;i++))
        do
                echo " "
        done
}

checkIfSymfonyAvailable()
{
        for dd in $webbase/*
        do
		if [ -d "$dd" ]; then
                        if [ -f $dd/$verifyfile ]; then
                                return 0;
                        fi
                fi
        done
        return 1
}

theupdatemenu()
{
        echo ;figlet "Updatemenu"
        echospaceline 3
        echotext "\tVersion: $Version" "Yel"
        echotext "\tAuthor: $Author" "Gre"
        echospaceline 2
		echotext "\t0 um das Updatescript zu aktualisieren" "Cya"
        echospaceline 1
        if checkIfSymfonyAvailable; then
                echospaceline 1
                echotext "\t1 fuer vollstaendiges Update"
                echospaceline 1
        fi
        echotext "\t2 fuer Update des Betriebssystems"
        if checkIfSymfonyAvailable; then
                echospaceline 1
                echotext "\t3 fuer Update von Symfony"
                echospaceline 1
        fi
        echotext "\t4 Installation / Update node.js"
	echotext "\t5 Installation composer"
        echospaceline 2
		echotext "\t9 fuer System herunterfahren"
        echospaceline 1

        echotext "\tBitte eine Auswahl treffen oder [x] um das Menue zu beenden:    " "Pur"

}

updateSystem()
{
        echospaceline 2
        echotext "Es wird mit dem Systemupdate begonnen" "Gre"
        echospaceline 1
        apt-get update
        apt-get -y upgrade
        apt-get -y dist-upgrade
        apt-get autoclean
}

updateNode()
{
	if [ -f "node.bash" ]; then
		bash node.bash
		sleep 5
	else
		echotext "Die Datei node.bash wurde nicht gefunden" "Red"
		sleep 5
	fi
}

updateSymfony()
{
        echotext "Bitte wahlen Sie den Pfad Ihrer Symfonyinstallation aus:" "Gre"
        echospaceline 2
        echotext "Es werden nur Verzeichnisse ausgegeben, die eine Datei $verifyfile im Hauptverzeichnis beinhaltet" "Gre"
        echospaceline 1
        declare -a dirs
        i=1
        for d in $webbase/*
        do
                if [ -d "$d" ]; then
                        if [ -f $d/$verifyfile ]; then
                                dirs[i++]="${d%/}"
                        fi
                fi
        done
                if [ "${#dirs[@]}" -gt "1" ]; then
                        for((i=1;i<=${#dirs[@]};i++))
            do
                echo "$i)    ${dirs[i]}"
            done

            echospaceline 2

                read -n1 -r -p "Bitte Nummer eingeben oder x um das Symfonyupdate abzubrechen:   " i

                if [ $i == "x" ]
                    then
                        return
                fi
            else
                echotext "Es wurde nur eine Symfonyinstallation gefunden" "Yel"
                i=1
                fi


        path=${dirs[i]}
        echospaceline 1
        echotext "Symfony wird im folgenden Pfad aktualisiert: $path" "Gre"
        echospaceline 1

        if [ -d "$path" ]; then

                read -n1 -r -p "Soll von der aktuellen Version ein Backup erstellt werden ? (J|N)     " backup
                echospaceline 1
                case $backup in
                        Y|y|J|j)
                                echotext "Die aktuelle Symfonyinstallation wird nachfolgend komplett als Backup gespeichert" "Gre"
                                echospaceline 1
                                if [ -d "$pathbackup" ]; then
                                        echotext "Verzeichnis $pathbackup ist bereits vorhanden" "Gre"
                                        echospaceline 1
                                else
                                        mkdir $pathbackup
                                        echotext "Das Verzeichnis $pathbackup wurde erstellt" "Red"
                                        echospaceline 1
                                fi

                                cp $path $pathbackup/symfony -R


                                echotext "Das Backup war erfolgreich" "Gre"
                                ;;
                        n|N)
                                echotext "Es wird kein Backup angefertigt" "Red"
                                ;;
                        *)      echotext "Ihre eingabe konnte nicht verarbeitet werden" "Red"
                                ;;

                esac

                echospaceline 1
                cd $path
                rm composer.json
                echotext "Die aktuelle composer.json Datei wird heruntergeladen" "Gre"
                echospaceline 1

                wget $fileurl/composer.json

                composer selfupdate

                composer update

                clearCache

                clearCacheProd
                echospaceline 1
                echotext "Das aktuelle Symfonymenu wird heruntergeladen" "Gre"
                echospaceline 1
		rm symfonymenu.sh*
                wget $fileurl/symfonymenu.sh
                echospaceline 1
		chown www-data:www-data $path/* -R                
        else
                echotext "Es wurde kein Symfony gefunden" "Red"
        fi
}

updateComposer
{
	curl -sS https://getcomposer.org/installer | php 
	mv composer.phar /usr/local/bin/composer
}

while true
do
		clear
        theupdatemenu
        read -n1 answer
        case ${answer} in
            0)      rm update.bash
                    rm parameter.bash
                    rm /var/www/symfony/symfonymenu.sh
                    wget http://base.rowoco.de/sonstiges/update.bash -P /root
                    wget http://base.rowoco.de/sonstiges/symfonymenu.sh -P /var/www/symfony
                    source update.bash
                    break
                    ;;
            1)      if checkIfSymfonyAvailable; then
                        updateSymfony
                    fi
                    updateSystem
                    echotext "Alles wurde aktualisiert" "Gre"
                    echospaceline 1
                    ;;
            2)      updateSystem
                    ;;
            3)      if checkIfSymfonyAvailable; then
                        updateSymfony
                    fi
                    ;;
            4)      updateNode
                    ;;
	    5)	    updateComposer
		    ;;
            9)      shutdown -h now
                    ;;
            x|X)    break
                    ;;
            *)      echotext "Bitte wiederholen Sie die Eingabe" "Red"
                    ;;
        esac
done
