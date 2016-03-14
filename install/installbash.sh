#!/usr/bin/env bash

rm /etc/bash.bashrc

OLD="menupath"
NEW="$2"
echo $NEW
DPATH="$2/bashrc/bash.bashrc"
BPATH="/etc"
TFILE="/tmp/out.tmp.$$"

[ ! -d $BPATH ] && mkdir -p $BPATH || :
for f in $DPATH
do
  if [ -f $f -a -r $f ]; then
    /bin/cp -f $f $BPATH
   sed "s/$OLD/$NEW/g" "$f" > $TFILE && mv $TFILE "$f"
  else
   echo "Error: Cannot read $f"
  fi
done
/bin/rm $TFILE


#bash $1