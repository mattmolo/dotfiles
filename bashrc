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

source ~/.profile

##############################################################################
# Shell prompt                                                               #
##############################################################################
# simple no color prompt
# export PS1="[\u@\h:\w] $ "
# multiline no color prompt
# export PS1="\n\u at \h in\w\n>> "
# multiline color prompt
export PS1="\n\e[0;31m\u\e[m at \e[0;33m\h\e[m in \e[m\e[0;36m\w\e[m\n\e[0;32m>>\e[m "
