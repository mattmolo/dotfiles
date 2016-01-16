#
# Defines environment variables.
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Save 
platform=$(uname)    

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
export PATH="$PATH:~/Scripts"
export GOPATH="~/.go"

export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:$GOPATH/bin"
export PATH="$PATH:."

if [[ $platform == 'Darwin' ]]; then
    export HOMEBREW_CASK_OPTS="--appdir=/Application"
fi
