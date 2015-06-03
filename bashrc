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

##############################################################################
# Shell prompt                                                               #
##############################################################################
# simple no color prompt
# export PS1="[\u@\h:\w] $ "
# multiline no color prompt
# export PS1="\n\u at \h in\w\n>> "
# multiline color prompt
export PS1="\n\e[0;31m\u\e[m at \e[0;33m\h\e[m in \e[m\e[0;36m\w\e[m\n\e[0;32m>>\e[m "

##############################################################################
# Aliases                                                                    #
##############################################################################

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

source ~/.common_shell
