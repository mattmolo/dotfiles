#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables
dir=~/.dotfiles                   # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc common_shell vimrc" # list of files/folders to symlink in homedir

NORMAL=$(tput sgr0)  
RED=$(tput setaf 1)  
CYAN=$(tput setaf 6) 
##########

# create dotfiles_old in homedir
echo -e "$CYAN Creating $olddir for backup of any existing dotfiles in ~ $NORMAL"

if [ -d $olddir ]; then
    echo -e "$RED $olddir already exists. Delete it? $NORMAL \c"
    read -p "" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "\n$CYAN Removing $olddir $NORMAL"
        rm -rf $olddir
    fi    
    printf "\n"
fi

mkdir -p $olddir

# move any existing dotfiles in homedir to old dotfiles directory, then create symlinks from the homedir to any files in the dotfiles directory specified in $files
cd $dir
echo -e "$CYAN Moving any existing dotfiles from ~ to $olddir $NORMAL"

for file in $files; do
    mv ~/.$file $olddir 2>/dev/null
    echo -e "$CYAN Creating symlink to $file in home directory $NORMAL"
    ln -s $dir/$file ~/.$file
done

#also move vim folder just in case, no need to link 
mv ~/.vim $olddir 2>/dev/null

#install vim files
echo -e "$CYAN Installing vim plugins (takes a few seconds) $NORMAL"
vim +VundleInstall +qall 2&> /dev/null

# ask to install oh-my-zsh
echo -e "$RED Install oh-my-zsh? (Make sure to install zsh first) $NORMAL \c"
read -p "" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] 
then
    printf "\n"
    bash omz_install.sh
fi

# install plugins for go
echo -e "$RED Install go plugins? (Make sure to have a go install) $NORMAL \c"
read -p "" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] 
then
    printf "\n"
    bash go_install.sh
fi

echo -e "\n$CYAN Finished! $NORMAL"
