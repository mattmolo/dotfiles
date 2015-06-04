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


# Customize to your needs...

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
