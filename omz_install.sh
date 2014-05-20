#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables
dir=~/.dotfiles                   # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
ohmyzshfiles="mytheme.zsh-theme plugins zshrc" #oh-my-zsh files that are located in diff places
##########

# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    
    # Clone oh-my-zsh into .oh-my-zsh
    if [ ! -d ~/.oh-my-zsh/ ]; then
        echo -e "\e[46mInstalling oh-my-zsh\e[0m"
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
    
    # symlink oh-my-zsh theme and plugins and zshrc
    echo -e "\e[46mCreating symlink to mytheme.zsh-theme in oh-my-zsh/themes/\e[0m"
    rm -f ~/.oh-my-zsh/themes/mytheme.zsh-theme
    ln -s $dir/mytheme.zsh-theme ~/.oh-my-zsh/themes/mytheme.zsh-theme
    
    echo -e "\e[46mCreating symlink to custom plugins in oh-my-zsh/custom/plugins/\e[0m"
    rm -rf ~/.oh-my-zsh/custom/plugins
    ln -s $dir/plugins ~/.oh-my-zsh/custom/
    
    echo -e "\e[46mInstalling zsh-syntax-highlighting\e[0m"
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $dir/plugins/zsh-syntax-highlighting
    
    echo -e "\e[46mSetting up zshrc\e[0m"
    mv ~/.zshrc $olddir
    ln -s $dir/zshrc ~/.zshrc

    # Set the default shell to zsh if it isn't currently set to zsh
    echo -e "\e[31mDon't forget to change zsh to default shell! (chsh -s zsh)\e[0m"
    #chsh -s $(which zsh)

else
   echo -e "\e[31mPlease install zsh, then re-run this script!\e[0m"
   exit
fi
