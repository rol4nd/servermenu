#!/usr/bin/env bash

FILE="/tmp/out.$$"
GREP="/bin/grep"
#....
# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "Sie müssen sich als 'root' anmelden!" 1>&2
   exit 1
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')"
    SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  fi
done

Menufile=$DIR/update/menu.bash

source $DIR/update/header.bash

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
         3 "ProFTPD /MySQL / Apache2 / PHP5 installieren"
         4 "Symfonymenü installieren"
         5 "Reboot Server"
         6 "ShowPath")



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
        1) bash $DIR/update/update/update.bash $Menufile;;
		2) bash $DIR/update/bashrc/installbash.bash $Menufile;;
		3) bash $DIR/update/bashrc/installwebserver.bash $Menufile;;
		4) bash $DIR/update/symfony/installsymfony.bash $Menufile;;
		5) rebootserver;;
		6) echo $DIR
esac
