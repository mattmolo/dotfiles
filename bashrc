##############################################################################
# Filename: .bashrc                                                          #
# Colorful prompt and useful alias                                           #
##############################################################################

##############################################################################
# Shell prompt                                                               #
##############################################################################
# simple no color prompt
# export PS1="[\u@\h:\w] $ "
# multiline no color prompt
# export PS1="\n\u at \h in\w\n>> "
# multiline color prompt
export PS1="\n\e[0;31m\u\e[m at \e[0;33m\h\e[m in \e[m\e[0;36m\w\e[m\n\e[0;34m>>\e[m "
##############################################################################
# Aliases                                                                    #
##############################################################################
alias ..="cd .."
alias e="exit"
alias c="clear"
alias ls="ls -Gh --color=auto"
alias l="ls -Glah --color=auto"
