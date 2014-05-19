# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[white]%}on%{$reset_color%} git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"

# Prompt format: \n USER at HOST in DIRECTORY on git:BRANCH STATE \n >> 
#%{$terminfo[bold]$fg[cyan]%}#%{$reset_color%} \
PROMPT="
%{$fg[red]%}%n \
%{$fg[white]%}at \
%{$fg[yellow]%}$(box_name) \
%{$fg[white]%}in \
%{$fg[cyan]%}${current_dir}%{$reset_color%}\
${git_info} 
%{$fg[blue]%}>> %{$reset_color%}"
