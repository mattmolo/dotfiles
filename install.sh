#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables
dir=~/.dotfiles                   # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc aliases vimrc vim"          # list of files/folders to symlink in homedir
##########

# create dotfiles_old in homedir
echo -e "\e[46mCreating $olddir for backup of any existing dotfiles in ~\e[0m"

if [ ! -d $olddir/ ]; then
    read -p "\e[31m$olddir already exists. Delete it?\e[0m" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]] then
        echo -e "\e[31mRemoving $olddir\e[0m"
        rm -r $olddir
    fi    
fi

mkdir -p $olddir

# move any existing dotfiles in homedir to old dotfiles directory, then create symlinks from the homedir to any files in the dotfiles directory specified in $files
cd $dir
echo -e "\e[46mMoving any existing dotfiles from ~ to $olddir\e[0m"
for file in $files; do
    mv ~/.$file $olddir
    echo -e "\e[46mCreating symlink to $file in home directory\e[0m"
    ln -s $dir/$file ~/.$file
done

# ask to install oh-my-zsh
read -p "\e[31mInstall oh-my-zsh? (Make sure to install zsh first)\e[0m" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] then
    sh omz_install.sh
fi 
