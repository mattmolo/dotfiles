##############################################################################
# Filename: .bashrc                                                          #
# Colorful prompt and useful alias                                           #
##############################################################################

##############################################################################
# General Settings                                                           #
##############################################################################
# Set the default editor to vim.
export EDITOR=vim
 
# Avoid succesive duplicates in the bash command history.
export HISTCONTROL=ignoredups
 
# unlimitedish history
export HISTFILE=~/.bash_history
export HISTSIZE=100000000
 
# Append commands to the bash command history file (~/.bash_history)
# instead of overwriting it.
#shopt -s histappend
 
# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
PROMPT_COMMAND='history -a'

source ~/.env
source ~/.aliases
source ~/.local_shellrc

##############################################################################
# Shell prompt                                                               #
##############################################################################
# simple no color prompt
# export PS1="[\u@\h:\w] $ "
# export PS1="\n\u at \h in \w >> "
# multiline no color prompt
# export PS1="\n\u at \h in \w\n>> "
# multiline color prompt
 export PS1="\n\[\e[0;31m\]\u\[\e[0m\] at \[\e[0;33m\]\h\[\e[0m\] in \[\e[0;36m\]\w\[\e[0m\] \[\e[0;32m\]\n>>\[\e[0m\] "
# color escapes must be like
# \[\e[0;33m\] (red) and \[\e[0m\] (clear)
