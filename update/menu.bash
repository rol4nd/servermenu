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

type dialog >/dev/null 2>&1 || apt-get -y -qq install dialog
type figlet >/dev/null 2>&1 || apt-get -y -qq install figlet

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=8
BACKTITLE="Serveradministrationsmenü"
TITLE="Servermenü"
MENU="Bitte wählen Sie Ihre Option:"

OPTIONS=(1 "Serverupdate durchführen"
         2 "Bashrc installieren"
         3 "Symfonymenü installieren"
         4 "Reboot Server")



showdialog()
{
    CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
}

showdialog

function rebootserver()
{
    read -p "Möchten Sie den Server wirklich neu starten? (j/n ) " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Jj]$ ]]
    then
        reboot
    else
        bash /opt/update/menu.bash
    fi

}
clear
case $CHOICE in
        1) bash /opt/update/update/update.bash $Menufile;;
		2) bash /opt/update/bashrc/installbash.bash $Menufile;;
		3) bash /opt/update/symfony/installsymfony.bash $Menufile;;
		4) rebootserver
esac
