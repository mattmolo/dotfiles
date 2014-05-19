# User Path Variable 
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mytheme"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras fuck brew compleat npm zsh-syntax-highlighting extract)

# Aliases
# Easy edits to zsh files
alias zshrc="vim ~/.zshrc; source ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# Easy directory traveral
alias ..="cd .."
alias ...="cd ../.."

# tiny aliases for misc things
alias c="print '\a'; clear;"
alias e="exit"
alias cc="cd; clear"
alias cdd="cd ~/Desktop/"
alias l='ls -lahF'
alias pt="ping 8.8.8.8"

# tmux things
alias tnew="tmux new"
alias tatt="tmux attach"
alias tls="tmux ls"

# git things
alias gadd="git add *"
alias gpull="git pull"
alias gpush="git push"
gcom () {
    git commit -m $1
}

gita () {
  git add *; git commit -m $1; git push;
}

# OS X things
alias chocho="while true; do /usr/local/opt/sl/bin/sl; done"
alias pb="pbpaste | pbcopy"
alias omega="mosh --ssh='ssh -p 2222' m -p 4050"
alias omegal="mosh --ssh='ssh -p 2222' l"

# linux things
alias apt="sudo aptitude"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=14

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
HIST_STAMPS="mm.dd.yyyy"

## Set EDITOR to /usr/bin/vim if Vim is installed
if [ -f /usr/bin/vim ]; then
    export EDITOR=/usr/bin/vim
fi

source $ZSH/oh-my-zsh.sh
