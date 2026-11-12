#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables
# Dotfiles directory
dir=~/.dotfiles
# Old dotfiles backup directory
olddir=~/dotfiles_old

# List of files/folders to symlink in homedir
files="bashrc aliases env vimrc tmux.conf ripgreprc gitconfig gitignore_global"

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

# make sure the machine-local files exist
touch ~/.local_shellrc ~/.gitconfig.local
if [ ! -f ~/.gitconfig.work ]; then
    touch ~/.gitconfig.work
    echo -e "$CYAN Created ~/.gitconfig.work: set [user] email there for repos under ~/work $NORMAL"
fi

# ask to install vim plugins
echo -e "$RED Install vim (Vundle) plugins? $NORMAL \c"
read -p "" -n 1 -r
printf "\n"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "$CYAN Installing vim plugins (takes a few seconds) $NORMAL"
    vim +VundleInstall +qall
    clear
fi

# ask to set up neovim
echo -e "$RED Set up neovim? (links ~/.config/nvim and makes it the editor) $NORMAL \c"
read -p "" -n 1 -r
printf "\n"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    mkdir -p ~/.config
    if [ "$(readlink ~/.config/nvim)" != "$dir/nvim" ]; then
        echo -e "$CYAN Moving any existing ~/.config/nvim to $olddir $NORMAL"
        mv ~/.config/nvim $olddir 2>/dev/null
        echo -e "$CYAN Creating symlink to nvim in ~/.config $NORMAL"
        ln -s $dir/nvim ~/.config/nvim
    fi

    # EDITOR is per machine, so it goes in the local rc file
    if ! grep -q "^export EDITOR=nvim" ~/.local_shellrc; then
        echo -e "$CYAN Setting EDITOR=nvim in ~/.local_shellrc $NORMAL"
        echo "export EDITOR=nvim" >> ~/.local_shellrc
    fi

    # nvim-treesitter needs the tree-sitter CLI to build parsers
    if ! command -v tree-sitter > /dev/null; then
        echo -e "$CYAN Installing tree-sitter CLI $NORMAL"
        if command -v brew > /dev/null; then
            brew install tree-sitter-cli
        elif [[ "$(uname)" == "Linux" ]]; then
            # distro packages are usually too old, so grab the release binary
            case "$(uname -m)" in
                x86_64) ts_arch=x64 ;;
                aarch64|arm64) ts_arch=arm64 ;;
                *) ts_arch="" ;;
            esac
            if [ -n "$ts_arch" ]; then
                mkdir -p ~/.local/bin
                curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-$ts_arch.gz" \
                    | gunzip > ~/.local/bin/tree-sitter \
                    && chmod +x ~/.local/bin/tree-sitter
                export PATH="$HOME/.local/bin:$PATH"
            fi
        fi
        if ! command -v tree-sitter > /dev/null; then
            echo -e "$RED Couldn't install tree-sitter CLI; treesitter parsers won't build $NORMAL"
        fi
    fi

    # language servers that need a toolchain are skipped until it's installed (see nvim/lua/plugins/lsp.lua)
    command -v go > /dev/null || missing="$missing go(gopls)"
    command -v npm > /dev/null || missing="$missing npm(pyright,ts_ls,vue_ls)"
    command -v cargo > /dev/null || missing="$missing cargo(rust_analyzer)"
    if [ -n "$missing" ]; then
        echo -e "$CYAN Not installed:$missing $NORMAL"
        echo -e "$CYAN Those language servers are skipped; they install on the next nvim launch once the tool is there $NORMAL"
    fi

    if command -v nvim > /dev/null; then
        echo -e "$CYAN Installing neovim plugins (takes a minute) $NORMAL"
        nvim --headless "+Lazy! sync" +qa
    else
        echo -e "$RED nvim isn't installed; plugins will install on its first launch $NORMAL"
    fi
fi

# ask to install oh-my-zsh
echo -e "$RED Install zsh-prezto? (Make sure to install zsh first) $NORMAL \c"
read -p "" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    printf "\n"
    bash prezto_install.sh
else
    printf "\n"
fi

echo -e "\n$CYAN Finished! $NORMAL"
