#!/bin/bash
############################
# This script checks for the tools these dotfiles use and installs any that are missing
# Works on MacOS (Homebrew) and Debian/Ubuntu (apt)
############################

NORMAL=$(tput sgr0)
RED=$(tput setaf 1)
CYAN=$(tput setaf 6)

platform=$(uname)
bin=~/.local/bin
mkdir -p $bin
export PATH="$bin:$PATH"

if [[ $platform == 'Darwin' ]]; then
    if ! command -v brew > /dev/null; then
        echo -e "$RED Install Homebrew first: https://brew.sh $NORMAL"
        exit 1
    fi
elif ! command -v apt-get > /dev/null; then
    echo -e "$RED Only Homebrew (MacOS) and apt (Linux) are supported $NORMAL"
    exit 1
fi

# Release binaries name the architecture differently
case "$(uname -m)" in
    x86_64) ts_arch=x64; nvim_arch=x86_64 ;;
    aarch64|arm64) ts_arch=arm64; nvim_arch=arm64 ;;
esac

# pkg <brew name> <apt name>
apt_updated=""
pkg() {
    if [[ $platform == 'Darwin' ]]; then
        brew install "$1"
    else
        if [ -z "$apt_updated" ]; then
            sudo apt-get update
            apt_updated=1
        fi
        sudo apt-get install -y "$2"
    fi
}

# check <command> <install command...>: runs the install command if <command> is missing
check() {
    local cmd=$1
    shift
    if command -v "$cmd" > /dev/null; then
        echo -e "$CYAN ✓ $cmd $NORMAL"
    else
        echo -e "$CYAN Installing $cmd $NORMAL"
        "$@" && command -v "$cmd" > /dev/null || echo -e "$RED Couldn't install $cmd $NORMAL"
    fi
}

########## Linux installs that apt doesn't do (or ships too old)

install_nvim() {
    if [[ $platform == 'Darwin' ]]; then
        brew install neovim
        return
    fi
    # apt's neovim is usually too old for this config
    rm -rf ~/.local/nvim && mkdir -p ~/.local/nvim &&
        curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-$nvim_arch.tar.gz" \
            | tar -xz -C ~/.local/nvim --strip-components=1 &&
        ln -sf ~/.local/nvim/bin/nvim $bin/nvim
}

install_tree_sitter() {
    if [[ $platform == 'Darwin' ]]; then
        brew install tree-sitter-cli
        return
    fi
    curl -fsSL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-linux-$ts_arch.gz" \
        | gunzip > $bin/tree-sitter && chmod +x $bin/tree-sitter
}

install_diff_so_fancy() {
    if [[ $platform == 'Darwin' ]]; then
        brew install diff-so-fancy
        return
    fi
    # a single perl script
    curl -fsSL -o $bin/diff-so-fancy https://github.com/so-fancy/diff-so-fancy/releases/latest/download/diff-so-fancy &&
        chmod +x $bin/diff-so-fancy
}

install_uv() {
    if [[ $platform == 'Darwin' ]]; then
        brew install uv
        return
    fi
    # installs to ~/.local/bin, which env already puts on the PATH
    curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
}

install_cc() {
    if [[ $platform == 'Darwin' ]]; then
        # opens a dialog; rerun this script once it finishes
        xcode-select --install
    else
        pkg "" build-essential
    fi
}

########## Tools

# needed by the installs below
check curl pkg curl curl
check unzip pkg unzip unzip
check cc install_cc

check git pkg git git
check zsh pkg zsh zsh
check tmux pkg tmux tmux
check wget pkg wget wget
check jq pkg jq jq
check rg pkg ripgrep ripgrep
check fzf pkg fzf fzf
check htop pkg htop htop
check btop pkg btop btop

# Debian/Ubuntu install bat as batcat (the aliases handle either)
if command -v batcat > /dev/null; then
    echo -e "$CYAN ✓ batcat $NORMAL"
else
    check bat pkg bat bat
fi

check nvim install_nvim
check tree-sitter install_tree_sitter
check diff-so-fancy install_diff_so_fancy

# python tools go through uv
check uv install_uv
check ipython uv tool install ipython
check virtualenv uv tool install virtualenv

########## Font: Hermit Nerd Font (named Hurmit once patched)

if [[ $platform == 'Darwin' ]]; then
    fontdir=~/Library/Fonts
else
    fontdir=~/.local/share/fonts
fi

if ls $fontdir/HurmitNerdFont* > /dev/null 2>&1; then
    echo -e "$CYAN ✓ Hermit Nerd Font $NORMAL"
else
    echo -e "$CYAN Installing Hermit Nerd Font $NORMAL"
    tmp=$(mktemp -d)
    mkdir -p $fontdir
    curl -fsSL -o $tmp/Hermit.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/Hermit.zip &&
        unzip -o -q $tmp/Hermit.zip '*.otf' -d $fontdir ||
        echo -e "$RED Couldn't install Hermit Nerd Font $NORMAL"
    rm -rf $tmp
    if command -v fc-cache > /dev/null; then
        fc-cache -f $fontdir
    fi
fi

echo -e "\n$CYAN Done! Set your terminal font to \"Hurmit Nerd Font Mono\" $NORMAL"
echo -e "$CYAN Language server toolchains (node, cargo, go) are optional; see the README $NORMAL"
