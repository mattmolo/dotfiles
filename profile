################################################
# Common shell configurations for zsh and bash #
################################################

# Save 
platform=$(uname)    


# load Z: https://github.com/rupa/z
. ~/.dotfiles/z.sh

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

if [[ $platform == 'Darwin' ]]; then
  export BROWSER='open'
fi

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

################################################
# Path configurations                          #
################################################

if [[ $platform == 'Linux' ]]; then
    export PATH="$PATH:/home/matt/Scripts"
    export GOPATH="/home/matt/.go"

elif [[ $platform == 'Darwin' ]]; then
    export PATH="$PATH:/Users/Matt/Projects/ROV/gcc/bin:/Users/Matt/Scripts"
    export GOPATH="/Users/Matt/.go"

    export HOMEBREW_CASK_OPTS="--appdir=/Application"
fi

export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:$GOPATH/bin"
export PATH="$PATH:."


################################################
# Aliases                                      #
################################################

# Easy edits to bash/zsh files
alias bashrc="vim ~/.bashrc; source ~/.bashrc"
alias zshrc="vim ~/.zshrc; source ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# Easy directory traveral
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# tiny aliases for misc things
alias c="print '\a'; clear;"
alias e="exit"
alias v="vim"
alias cdd="cd ~/Desktop/"
alias pt="ping 8.8.8.8"

# Highlight with 'moria' theme to terminal, and suppress errors
function hl { 
    highlight $1 $2 $3 -s moria -O xterm256 2> /dev/null

    if (($? != 0)); then # If the command had errors
        cat $1 # Just cat the file out instead
    fi
}

# tmux things
alias tnew="tmux new"
alias tatt="tmux attach"
alias tls="tmux ls"

# git things
alias gadd="git add"
alias gs="git status"
alias gpull="git pull"
alias gpush="git push"
alias gnotrack="git update-index --assume-unchanged"
alias gtrack="git update-index --no-assume-unchanged"

gcom () {
    git commit -am $1
}

gita () {
  git add *; git commit -m $1; sleep 1; git push;
}


if [[ $platform == 'Linux' ]]; then
    # Linux things
    alias apt="sudo aptitude"
    alias ls='ls --color=auto'
    alias l='ls -lahF --color=always'
    alias mc='tatt -t Minecraft'
    alias ml="module load"
    alias m="module"
elif [[ $platform == 'Darwin' ]]; then
    # OS X things
    alias choochoo="while true; do /usr/local/opt/sl/bin/sl; done"
    alias pb="pbpaste | pbcopy"
    alias m="ssh m"
    alias ls='ls -G'
    alias l='ls -lahFG'
    alias o="open"
fi


# extract a file
function extract {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ] ; then
      # NAME=${1%.*}
      # mkdir $NAME && cd $NAME
      case $1 in
        *.tar.bz2) tar xvjf ../$1 ;;
        *.tar.gz) tar xvzf ../$1 ;;
        *.tar.xz) tar xvJf ../$1 ;;
        *.lzma) unlzma ../$1 ;;
        *.bz2) bunzip2 ../$1 ;;
        *.rar) unrar x -ad ../$1 ;;
        *.gz) gunzip ../$1 ;;
        *.tar) tar xvf ../$1 ;;
        *.tbz2) tar xvjf ../$1 ;;
        *.tgz) tar xvzf ../$1 ;;
        *.zip) unzip ../$1 ;;
        *.Z) uncompress ../$1 ;;
        *.7z) 7z x ../$1 ;;
        *.xz) unxz ../$1 ;;
        *.exe) cabextract ../$1 ;;
        *) echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}
alias x="extract"
