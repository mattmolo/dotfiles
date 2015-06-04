#!/bin/bash
############################
# Tries to install some dependencies for vim-go and tagbar
############################

########## Variables
NORMAL=$(tput sgr0)  
PROMPT=$(tput setaf 6) #Cyan Prompt Color
##########

if [[ -z "$GOPATH" ]]; then
  platform=$(uname)    
  if [[ $platform == 'Linux' ]]; then
    export GOPATH="/home/matt/.go"
  elif [[ $platform == 'Darwin' ]]; then
    export GOPATH="/Users/Matt/.go"
  fi
fi

echo -e "$PROMPT Installing go binaries (vim-go) $NORMAL"
vim +GoInstallBinaries +qall 2&> /dev/null

echo -e "$PROMPT Installing gotags (tagbar) $NORMAL"
go get -u github.com/jstemmer/gotags
