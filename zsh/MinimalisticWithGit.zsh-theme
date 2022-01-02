# purple username

directory() {
   echo "%1~"
}

return_status() {
   echo "%(?..%{$fg[red]%}%?%f )"
}

# set the git_prompt_info text
ZSH_THEME_GIT_PROMPT_PREFIX=" ["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""

ZSH_THEME_GIT_PROMPT_PREFIX=" ["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_AHEAD='^'
ZSH_THEME_GIT_PROMPT_BEHIND='v'
ZSH_THEME_GIT_PROMPT_DIVERGED='<diverged>'
ZSH_THEME_GIT_PROMPT_DELETED='x'

# putting it all together
# PROMPT='%B$(return_status)$fg[blue]$(directory)$fg[green]$(git_prompt_info)%b '
#PROMPT='%B$(return_status)$fg[blue]$(directory)$fg[green]$(git_prompt_info)%b ❯ '
PROMPT='%B$(return_status)$fg[blue]$(directory)$fg[green]$(git_prompt_info)$fg[red]$(git_prompt_status)%b ❯ '
#RPROMPT='$(return_status)'
