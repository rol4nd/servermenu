#!/bin/sh

#....
# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "Sie müssen sich als 'root' anmelden!" 1>&2
   exit 1
fi
path=`pwd`;

themenu()
{
	echo "${LIGHTGRAY}";figlet "Symfony2"
	echo " "
	echo " "
	echo " -- Symfony Consolenbefehle --"
	echo " "
	echo "1 = Weblink / CacheClear"
	echo " "
	echo " "
	echo "2 = Translationfile "
	echo " "
	echo " "
	echo "4 => php app/console assetic:dump"
	echo "5 => php app/console assetic:dump --watch"
	echo " "
	echo " ###  Allgemeine Funktionen ###"
        echo " "
        echo "10 => php app/console generate:bundle"
	echo " "
	echo " ### Tabellenfunktionalitaeten ### "
	echo " "
	echo "20 => Erstellen aller vorhandenen Entities (Achtung alles bisherige wird ueberschrieben"
	echo "22 => Erstellener einer Entity"
	echo " "
	echo "33 => php app/console router:debug (Zeigt alle Routen an)"
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
	#chown www-data:www-data $path/app/cache/* -R
	#chown www-data:www-data $path/app/logs -R
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
	php $path/app/console ca:cl
}

clearCacheProd()
{
	php $path/app/console ca:cl --env=prod
}

installWebSymlink()
{
	php app/console assets:install web --symlink
}

asseticDump()
{
	php app/console assetic:dump
	setOwner
}

asseticDumpWatch()
{
	php app/console assetic:dump --watch
}

translationfileUpdate()
{
	echo " "
        echo "Bitte geben Sie den Namensraum an:"
        read namespace
        echo " "
        echo "Bitte geben Sie das Bundle - ohne Bundle - an in dem die Entities erstellt werden sollen: "
        read bundle

	bundlenew=$bundle"Bundle"
        dir=$path/src/$namespace/$bundlenew

	php app/console translation:extract de --dir=$path/src/$namespace/ --output-dir=$path/src/$namespace/$bundlenew/Resources/translations

	setOwner
}
createNewBundle()
{
        php app/console generate:bundle
        installWebSymlink()
        setOwner
}

createDoctrineEntities()
{
	echo " "
	echo "Bitte geben Sie den Namensraum an:" 
	read namespace
	echo " "
       	echo "Bitte geben Sie das Bundle - ohne Bundle - an in dem die Entities erstellt werden sollen: "
	read bundle
	
	bundlenew=$bundle"Bundle"
	dir=$path/src/$namespace/$bundlenew
	
	if [ -d "$dir" ]; then
		php app/console doctrine:mapping:convert xml $dir/Resources/config/doctrine/metadata/orm --from-database --force
		php app/console doctrine:mapping:convert yml $dir/Resources/config/doctrine/metadata/orm --from-database --force
        	php app/console doctrine:mapping:import $namespace$bundlenew
        	php app/console doctrine:generate:entities $namespace$bundlenew
        	php app/console doctrine:cache:clear-metadata
	else
		echo " *************************************************** "
		echo " "
		echo " Es existiert kein Bundle $dir, bitte geben Sie die Daten erneut ein"
		echo " "
		echo " *************************************************** "
		echo " "
		echo " "
		createDoctrineEntities
	fi
}

createOneDoctrineEntity()
{
	echo " "
	echo "Bitte den Namen der Entity angeben - z.B.: TabelleIrgendwas:"
	read entity
	
	bundlenew=$bundle"Bundle"
        dir=$path/src/$namespace/$bundlenew

	php app/console doctrine:mapping:convert yml $dir/Resources/config/doctrine/metadata/orm --from-database --force --filter="$entity"
	php app/console doctrine:mapping:import $namespace$bundlenew --filter="$entity"
	php app/console doctrine:generate:entities $namespace$bundlenew:$entity --no-backup --path="./src/"

}
weblinkCache()
{
	installWebSymlink
	clearCacheProd
	clearCache
	setOwner
}

routeDebuggen()
{
	php app/console router:debug
}

while true
do

	themenu

	read answer
	clear
	case $answer in
		1) weblinkCache;;
		2) translationfileUpdate;;
		4) asseticDump;;
		5) asseticDumpWatch;;
		10) createNewBundle;;
		20) createDoctrineEntities;;
		22) createDoctrineEntitiy;;
		33) routeDebuggen;;
		99) symfonyUpdate;;
	  	x) break;;

	esac

done

