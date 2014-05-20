!#/bin/bash
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
    
    # Clone oh-my-zsh into .oh-my-zsh using wget
    if [ ! -d ~/.oh-my-zsh/ ]; then
        echo -e "[31mInstalling oh-my-zsh"
        wget --no-check-certificate http://install.ohmyz.sh -O - | sh    
    fi
    
    # symlink oh-my-zsh theme and plugins and zshrc
    echo -e "[31mCreating symlink to mytheme.zsh-theme in oh-my-zsh/themes/"
    rm ~/.oh-my-zsh/themes/mytheme.zsh-theme
    ln -s $dir/mytheme.zsh-theme ~/.oh-my-zsh/themes/mytheme.zsh-theme
    
    echo -e "[31mCreating symlink to custom plugins in oh-my-zsh/custom/plugins/"
    rm ~/.oh-my-zsh/custom/plugins/ -r
    ln -s $dir/plugins ~/.oh-my-zsh/custom/
    
    echo -e "[31mInstalling zsh-syntax-highlighting"
    cd $dir/plugins
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
    cd $dir
    
    echo -e "[31mSetting up zshrc"
    mv ~/.$file $olddir
    ln -s $dir/zshrc ~/.zshrc

    # Set the default shell to zsh if it isn't currently set to zsh
    echo -e "[31mDon't forget to change zsh to default shell! (chsh -s zsh)"
    #chsh -s $(which zsh)


else
   echo -e "[31mPlease install zsh, then re-run this script!"
   exit
fi
