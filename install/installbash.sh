#!/usr/bin/env bash

rm /etc/bash.bashrc

OLD="menupath"
NEW=$2

cp $2/bashrc/bash.bashrc /etc/bash.bashrc
rpl $OLD $NEW /etc/bash.bashrc
source ~/.bashrc

bash $1