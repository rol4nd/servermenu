#!/usr/bin/env bash

source /opt/update/header.bash

echotext "Bashrc wird installiert\n" "Gre"

rm /etc/bash.bashrc
cp /opt/update/bashrc/bash.bashrc /etc/bash.bashrc

bash $1