#!/usr/bin/env bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "Sie müssen sich als 'root' anmelden!" 1>&2
   exit 1
fi

# This file should be the Start of all function

# Get the current mainfolder
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

DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo "Menu is install in '$DIR'"

Startfile=$DIR/start.sh

# This features are the minimum for using the menu
type dialog >/dev/null 2>&1 || apt-get -y -qq install dialog
type figlet >/dev/null 2>&1 || apt-get -y -qq install figlet
type vim >/dev/null 2>&1 || apt-get -y -qq install vim

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=8
BACKTITLE="Serveradministration/-installation"
TITLE="Servermenu"
MENU="Please choose a option:"

OPTIONS=(1 "Update Server"
         2 "Install Bashrc"
         3 "Install ProFTPD /MySQL / Apache2 / PHP5"
         4 "Prepare for using Symfony"
         5 "Symfonymenü installieren"
         6 "Reboot Server")

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

clear
case $CHOICE in
        1) bash $DIR/update/update.sh $Startfile $DIR;;
		2) bash $DIR/bashrc/installbash.bash $Startfile $DIR;;
		3) bash $DIR/install/installwebserver.sh $Startfile $DIR;;
		4) bash $DIR/install/installsymfony.sh $Startfile $DIR;;
		5) rebootserver;;
esac

