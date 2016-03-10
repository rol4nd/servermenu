#!/bin/bash

#Header
Version="0.4"
Author="Roland Wollenschlaeger"

#Files
parameterfile=parameter.bash
color=colors.bash
updatescript=updatescript.bash
bashfile=bash.bashrc
node=node.bash

url=http://base.rowoco.de/sonstiges

#Current folder
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Delete current files
rm ${color}
rm ${updatescript}
rm /etc/${bashfile}
rm ${node}

#Download actual files
wget $url/${updatescript} -P $DIR
wget $url/${color} -P $DIR
wget $url/${bashfile} -P /etc
wget $url/${node} -P $DIR

apt-get install dos2unix
apt-get install figlet

dos2unix ${node}

#Using colors for the next steps
source $color

#Check if parameterfile exists
if [ ! -f $parameterfile ]; then
	touch $parameterfile
	echo "#!/bin/bash" >> $parameterfile
	read -p "Existiert auf diesem Server eine Symfonyinstallation? j|n          " symfonyinstallation
	case $symfonyinstallation in
		j|J|y|Y)

			while true
			do
				read -p "Wie lautet die URL für die composer.json:          " answer
				wget_output=$(wget -q "$answer/composer.json")
				if [ $? -ne 0 ]; then
					echo -e "${Red}File konnte nicht gefunden werden${RCol}"
				else
					echo "fileurl=$answer" >> $parameterfile
					if [ -f "composer.json" ]; then
						rm composer.json
					fi
					break;
				fi
			done

			while true
			do
				read -p "Wie lautet die Webbase:                            " answer
				if [ ! -d "$answer" ]; then
					echo -e "${Red}Dieses Verzeichnis existiert nicht${RCol}"
				else
					echo "webbase=$answer" >> $parameterfile
					break;
				fi
			done

			while true
			do
				read -p "Wie lautet der Backup-Pfad:                        " answer
				if [ ! -d "$answer" ]; then
					echo -e "${Red}Dieses Verzeichnis existiert nicht${RCol}"
					read -p "Soll das Verzeichnis angelegt werden? j|n   " anlegen
					if [ $anlegen == "j" ]; then
						mkdir $answer
						echo "pathbackup=$answer" >> $parameterfile
						break
					fi
				else
					echo "pathbackup=$answer" >> $parameterfile
					break
				fi
			done
	esac

	echo "verifyfile=composer.phar" >> $parameterfile
fi

source ${parameterfile}
source ${updatescript}