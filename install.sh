#!/usr/bin/env bash

###########################
# This script installs the dotfiles and runs all other system configuration scripts
# Most of this is shamelessly stolen and adapted from https://github.com/atomantic/dotfiles
# 
###########################

DEFAULT_EMAIL="raizyr@gmail.com"
DEFAULT_GITHUBUSER="raizyr"
DEFAULT_NAME="Chris McNabb"
DEFAULT_USERNAME="raizyr"

# include library helpers
source ./lib.sh

# make a backup directory for overwritten dotfiles
if [[ ! -e ~/.dotfiles_backup ]]; then
  mkdir ~/.dotfiles_backup
fi

bot "Hi. I'm going to setup your OSX system. First, I need to check some things so that I configure your system correctly."


fullname=`osascript -e "long user name of (system info)"`

if [[ -n "$fullname" ]];then
  lastname=$(echo $fullname | awk '{print $2}');
  firstname=$(echo $fullname | awk '{print $1}');
fi

if [[ -z $lastname ]]; then
  lastname=`dscl . -read /Users/$(whoami) | grep LastName | sed "s/LastName: //"`
fi
if [[ -z $firstname ]]; then
  firstname=`dscl . -read /Users/$(whoami) | grep FirstName | sed "s/FirstName: //"`
fi
email=`dscl . -read /Users/$(whoami)  | grep EMailAddress | sed "s/EMailAddress: //"`

if [[ ! "$firstname" ]];then
  response='n'
else
  echo -e "I see that your full name is $COL_YELLOW$firstname $lastname$COL_RESET"
  read -r -p "Is this correct? [Y|n] " response
fi

if [[ $response =~ ^(no|n|N) ]];then
  read -r -p "What is your first name? " firstname
  read -r -p "What is your last name? " lastname
fi
fullname="$firstname $lastname"

bot "Great $fullname, "

if [[ ! $email ]];then
  response='n'
else
  echo -e "The best I can make out, your email address is $COL_YELLOW$email$COL_RESET"
  read -r -p "Is this correct? [Y|n] " response
fi

if [[ $response =~ ^(no|n|N) ]];then
  read -r -p "What is your email? [$DEFAULT_EMAIL] " email
  if [[ ! $email ]];then
    email=$DEFAULT_EMAIL
  fi
fi
