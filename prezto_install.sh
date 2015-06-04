#!/bin/bash
############################
# This script installs oh-my-zsh and sets it up
# Only run after install.sh has been run first!
############################

########## Variables
dir=~/.dotfiles                   # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
zshfiles="zshrc zlogin zprofile zpreztorc zshenv" #oh-my-zsh files that are located in diff places

NORMAL=$(tput sgr0)  
RED=$(tput setaf 1)  
CYAN=$(tput setaf 6) 
##########

# Test to see if zsh is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    
    # Clone zprezto
    if [ ! -d ~/.zprezto/ ]; then
        echo -e "$CYAN Installing prezto $NORMAL"
        git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
    fi

    # move any existing dotfiles in homedir to old dotfiles directory, then create symlinks from the homedir to any files in the dotfiles directory specified in $files
    mkdir -p $olddir
    cd $dir
    for file in $zshfiles; do
        mv ~/.$file $olddir 2>/dev/null
        echo -e "$CYAN Creating symlink to $file in home directory $NORMAL"
        ln -s $dir/$file ~/.$file 2>/dev/null
    done

    cp zprompt ~/.zprezto/modules/prompt/functions/prompt_molo_setup 2>/dev/null
    
    # Set the default shell to zsh if it isn't currently set to zsh
    echo -e "$RED Change default shell to zsh? $NORMAL \c"
    read -p "" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "\n$CYAN Changing default shell $NOMRAL"
        chsh -s $(which zsh)
    fi    
    echo -e "\n$CYAN Finished configuring ZSH! $NORMAL"
    exit

else
   echo -e "$RED Please install zsh, then re-run this script! $NORMAL"
   exit
fi
