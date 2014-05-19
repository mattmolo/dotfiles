#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables
dir=~/.dotfiles                   # dotfiles directory
olddir=~/dotfiles_old            # old dotfiles backup directory
files="bashrc vimrc vim zshrc"    # list of files/folders to symlink in homedir
ohmyzshfiles="mytheme.zsh-theme plugins" #oh-my-zsh files that are located in diff places
##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir

# move any existing dotfiles in homedir to old dotfiles directory, then create symlinks from the homedir to any files in the dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone oh-my-zsh into .oh-my-zsh using wget
    if [ ! -d ~/.oh-my-zsh/ ]; then
        echo "Installing oh-my-zsh"
        wget --no-check-certificate http://install.ohmyz.sh -O - | sh    
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    echo "Changing zsh to default shell"
    chsh -s $(which zsh)

    #symlink oh-my-zsh theme and plugins
    echo "Creating symlink to mytheme.zsh-theme in oh-my-zsh/themes/"
    ln -s $dir/mytheme.zsh-theme ~/.oh-my-zsh/themes/mytheme.zsh-theme
    echo "Creating symlink to custom plugins in oh-my-zsh/custom/plugins/"
    ln -s $dir/plugins ~/.oh-my-zsh/custom/plugins
    echo "Installing zsh-syntax-highlighting"
    cd $dir/plugins
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
    cd $dir

else
   echo "Please install zsh, then re-run this script!"
   exit
fi
}

install_zsh
