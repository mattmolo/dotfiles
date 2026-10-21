#
# Executes commands at the start of an interactive session.
#

# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE          # prezto defaults this to 10000, which caps the history file

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.
setopt nomenucomplete

unsetopt listambiguous           # Don't need to press tab twice to complete

# Allow zsh to complete commands after 'sudo'
zstyle ':completion::complete:sudo::' 'user-context' root
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# Make Ctrl-z also resume background process
fancy-ctrl-z () {
    if [[ $#BUFFER -eq 0 ]]; then
        BUFFER="fg"
        zle accept-line
    else
        zleush-input
        zle clear-screen
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# load Z: https://github.com/rupa/z
. ~/.dotfiles/bin/z.sh

# fzf: Ctrl-R searches history, Ctrl-T inserts a file path, Alt-C / Ctrl-F cds into a subdirectory.
# `fzf --zsh` needs fzf 0.48+; older Debian/Ubuntu packages ship the scripts instead.
if fzf --zsh &> /dev/null; then
    source <(fzf --zsh)
elif [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
fi
# Alt-C needs iTerm2's Option-as-Esc+, so also put the cd picker on Ctrl-F ("folder")
bindkey -M viins '^F' fzf-cd-widget
bindkey -M vicmd '^F' fzf-cd-widget

source ~/.aliases
source ~/.local_shellrc
