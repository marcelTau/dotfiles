# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mtaubert/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="spaceship"
SPACESHIP_PROMPT_DEFAULT_PREFIX='/ '
# eval spaceship_vi_mode_enable
## Git replacement symbols
#SPACESHIP_GIT_SYMBOL='git:'
SPACESHIP_GIT_SYMBOL=

SPACESHIP_GIT_STATUS_UNTRACKED='?'
SPACESHIP_GIT_STATUS_AHEAD='^'
SPACESHIP_GIT_STATUS_BEHIND='v'
SPACESHIP_GIT_STATUS_DIVERGED='<diverged>'
SPACESHIP_GIT_BRANCH_COLOR='green'

## Pyenv
#SPACESHIP_PYENV_SYMBOL="pyenv:"
#export SPACESHIP_PROMPT_DEFAULT_PREFIX='❯ '

## Time
SPACESHIP_TIME_SHOW=true
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_SYMBOL=
SPACESHIP_EXIT_CODE_SUFFIX=' '
SPACESHIP_EXIT_CODE_PREFIX=



SPACESHIP_PROMPT_ORDER=(
    dir
    git
    exec_time
    line_sep
    exit_code
    vi_mode
    char
)

# Hacks to get RPOMPT on top line :)
function spaceship_rprompt_prefix() {
  echo -n '%{'$'\e[1A''%}'
}

function spaceship_rprompt_suffix() {
  echo -n '%{'$'\e[1B''%}'
}

# RPROMPT
SPACESHIP_RPROMPT_ORDER=(
  rprompt_prefix
  time
  rprompt_suffix
)
# Prompt replacement symbols
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

bindkey 'Ö' autosuggest-accept
bindkey 'ö' autosuggest-accept

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(zsh-vi-mode sudo zsh-autosuggestions extract zsh-syntax-highlighting)
export RPS1="%{$reset_color%}"
source $ZSH/oh-my-zsh.sh
# Prefix
# Prompt replacement symbols
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# map vim to be nvim
alias vim="~/.config/nvim/nvim.appimage"

# switch the monitors
alias startup="~/my_scripts/startup.sh"

# GIT remaps
alias ga="git add"
alias gcm="git commit -m"
alias gs="git status"
alias gd="git diff"

# quick dotfiles edits
alias zshedit="vim ~/.zshrc"
alias vimedit="vim ~/.config/nvim/init.vim"
alias i3edit="vim ~/.config/i3/config"

# quick start to clion
# alias clion="~/my_scripts/clion_start.sh"

# cheatsheet
alias cht="~/my_scripts/cheatsheet.sh"

# EPITECH coding style checker
alias normcheck="~/my_scripts/norm.sh"

#alias mynew='( . cd $(find ~/GIT/tek2 -mindepth 1 -maxdepth 3 -type d | grep "B-" | fzf -e ))'
#
alias mfind=". ~/my_scripts/find.sh"

# tmux settings
alias ta="tmux attach"
alias tn="tmux new"
alias tl="tmux ls"
alias tks="tmux kill-server"
alias tss="tmux switch -t"
alias td="tmux detach"
