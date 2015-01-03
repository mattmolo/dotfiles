#!/bin/bash
############################
# This script installs oh-my-zsh and sets it up
# Only run after install.sh has been run first!
############################

########## Variables
dir=~/.dotfiles                   # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
ohmyzshfiles="mytheme.zsh-theme plugins zshrc" #oh-my-zsh files that are located in diff places
##########

# Test to see if zsh is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    
    # Clone oh-my-zsh into .oh-my-zsh
    if [ ! -d ~/.oh-my-zsh/ ]; then
        echo -e "\e[36mInstalling oh-my-zsh\e[0m"
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
    
    # symlink oh-my-zsh theme and plugins and zshrc
    echo -e "\e[36mCreating symlink to mytheme.zsh-theme in oh-my-zsh/themes/\e[0m"
    rm -f ~/.oh-my-zsh/themes/mytheme.zsh-theme
    ln -s $dir/mytheme.zsh-theme ~/.oh-my-zsh/themes/mytheme.zsh-theme
    
    echo -e "\e[36mCreating symlink to custom plugins in oh-my-zsh/custom/plugins/\e[0m"
    rm -rf ~/.oh-my-zsh/custom/plugins
    ln -s $dir/plugins ~/.oh-my-zsh/custom/
    cd ~/.oh-my-zsh/
    git update-index --assume-unchanged custom/plugins/example/example.plugin.zsh
    cd $dir
    
    echo -e "\e[36mInstalling zsh-syntax-highlighting\e[0m"
    rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $dir/plugins/zsh-syntax-highlighting
    
    echo -e "\e[36mSetting up zshrc\e[0m"
    mkdir -p $olddir #just in case it was deleted
    mv ~/.zshrc $olddir 2>/dev/null
    ln -s $dir/zshrc ~/.zshrc

    # Set the default shell to zsh if it isn't currently set to zsh
    echo -e "\e[31mChange default shell to zsh?\e[0m \c"
    read -p "" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "\n\e[36mChanging default shell\e[0m"
        chsh -s $(which zsh)
    fi    
    echo -e "\n\e[36mFinished configuring ZSH!\e[0m"
    exit

else
   echo -e "\e[31mPlease install zsh, then re-run this script!\e[0m"
   exit
fi
