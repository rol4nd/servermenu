#!/bin/bash
#apt-get install figlet
#------------------------------------------////
# Lapbox ~/.bashrc file
# Last Modified 20 January 2009
# Running on Debian GNU/Linux - Lenny
#------------------------------------------////
#------------------------------------------////
# Colors:
#------------------------------------------////
black='\e[0;30m'
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
purple='\e[0;35m'
brown='\e[0;33m'
lightgray='\e[0;37m'
darkgray='\e[1;30m'
lightblue='\e[1;34m'
lightgreen='\e[1;32m'
lightcyan='\e[1;36m'
lightred='\e[1;31m'
lightpurple='\e[1;35m'
yellow='\e[1;33m'
white='\e[1;37m'
nc='\e[0m'

#------------------------------------------////
# Proxy:
#------------------------------------------////
#http_proxy=http://127.0.0.1:8118/
#HTTP_PROXY=$http_proxy
#export http_proxy HTTP_PROXY

#------------------------------------------////
# Aliases:
#------------------------------------------////
## make ls list by size
##alias ls='du -s */* | sort -n'
alias findbig='find . -type f -exec ls -s {} \; | sort -n -r | head -5'
alias ports='netstat -nape --inet'
alias opennet='lsof -i'
alias mcorgadmin='ssh -p XXXX hbserv1 -l XXXXXX'
alias ping='ping -c 4'
alias ns='netstat -alnp --protocol=inet'
alias search='aptitude search'
alias show='aptitude show'
alias ls='ls -aFl --color=always'
alias la='ls -Al'
alias lx='ls -lXB'
alias lk='ls -lSr'
alias lc='ls -lcr'
alias lu='ls -lur'
alias lr='ls -lR'
alias lt='ls -ltr'
alias lm='ls -al |more'
alias ld='ls -p | grep "/"'
alias sam=serveradministrationmenu
alias cu=loggingout

#alias rm='rm -i'
#------------------------------------------////
# Functions and Scripts:
#------------------------------------------////

serveradministrationmenu()
{
    bash /opt/servermenu/menu.bash
}

tcf()
{
    watch "ls -lrth | tail -${1}"
}

loggingout()
{
    echo ""
    echo "Schade dass du schon gehst :)"
    echo ""
    sleep 1
    echo "Bis bald!"
    echo ""
    sleep 2
    logout
}

localnet ()
{
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    echo ""
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    echo ""
}

myip ()
{
	echo -ne `hostname -I`
}

upinfo ()
{
    echo -ne "${green}$HOSTNAME ${red}uptime is ${cyan} \t ";uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
}

debversion()
{
	echo -ne "Debian Version: " $(cat /etc/debian_version | cut -b -3)
}

cd() 
{
  if [ -n "$1" ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

encrypt ()
{
    gpg -ac --no-options "$1"
}

decrypt ()
{
    gpg --no-options "$1"
}

extract()
{
    if [ -f "$1" ] ; then
    case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz) tar xzf "$1" ;;
    *.tar.Z) tar xzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.jar) unzip "$1" ;;
    *.tar) tar xf "$1" ;;
    *.tbz2) tar xjf "$1" ;;
    *.tgz) tar xzf "$1" ;;
    *.zip) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *) echo "'$1' cannot be extracted." ;;
    esac
    else
    echo "'$1' is not a file."
    fi
}

#------------------------------------------////
# Some original .bashrc contents:
#------------------------------------------////
# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#------------------------------------------////
# Prompt:
#------------------------------------------////


PS1='\[\033[01;32m\]\u\[\033[01;34m\]@\[\033[01;31m\]\h\[\033[00;34m\]{\[\033[01;34m\]\w\[\033[00;34m\]}\[\033[01;32m\]:\[\033[00m\]'

#------------------------------------------////
# System Information:
#------------------------------------------////
clear
echo -e "${LIGHTGRAY}";figlet `hostname`;
echo -ne "${red}Today is:\t\t${cyan}" `date`; echo ""
echo -e "${red}Kernel Information: \t${cyan}" `uname -smr`
echo -e "${cyan}";upinfo;echo ""
echo -e "${cyan}";debversion;echo ""
echo -e "${cyan}IP-Adresse ";myip;echo "" 
