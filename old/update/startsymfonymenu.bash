#!/usr/bin/env bash

FILE="/tmp/out.$$"
GREP="/bin/grep"
#....
# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "Sie müssen sich als 'root' anmelden!" 1>&2
   exit 1
fi

Menufile=/opt/update/menu.bash

source /opt/update/header.bash

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=4
BACKTITLE="Symfonyadministration"
TITLE="Symfonyinstallationen"
MENU="Bitte wählen Sie die gewünschte Installation:"

filenameorigin="/opt/update/symfony/symfonypath.txt"
    c=1
    w=()
    choices=()
    while read line;do
        w+=($c "$line")
        choices+=("$line")
        ((c++))
        ((i++))
    done < $filenameorigin

getsymfonyfolders()
{

    CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${w[@]}" \
                2>&1 >/dev/tty)

    CHOICE=$((CHOICE-1))
    cd ${choices[CHOICE]}
    echo -e "${choices[CHOICE]}"
    #sh "${choices[CHOICE]}"symfonymenu.sh
}

getsymfonyfolders