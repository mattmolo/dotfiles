!$/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables
dir=~/.dotfiles                   # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim"          # list of files/folders to symlink in homedir
##########

# create dotfiles_old in homedir
echo -e "[31mCreating $olddir for backup of any existing dotfiles in ~"
rm -r $olddir
mkdir -p $olddir

# change to the dotfiles directory
echo -e "[31mChanging to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to old dotfiles directory, then create symlinks from the homedir to any files in the dotfiles directory specified in $files
echo -e "[31mMoving any existing dotfiles from ~ to $olddir"
for file in $files; do
    mv ~/.$file $olddir
    echo -e "[31mCreating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

sh install_omz.sh
