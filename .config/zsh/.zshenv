# first dotfile to be loaded - define zsh environment variables

# dotfiles directory synced to github
export DOTDIR="${HOME}"

# rest of zsh dotfile configuration
export ZDOTDIR="${HOME}/.config/zsh"

# custom config files/plugins
export ZSH_CUSTOM="${ZDOTDIR}/custom"

# locations for additional functons
export fpath=( "${ZDOTDIR}/functions" ${fpath[@]} )

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# running yadm bootstrap already updates
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

### HISTORY SETTINGS ###

HISTFILE="${ZDOTDIR}/zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory

# History Control: Omit duplicate and commands that begin with a space
export HISTCONTROL='ignoreboth';

# Change ZSH_COMPDUMP location
HOST_VER=$(uname -r)
ZSH_COMPDUMP="${HOME}/.cache/zcompdump-${HOST_VER}-${ZSH_VERSION}"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Set default applicaitons

export EDITOR='nvim'
export PAGER='less'
export TERMINAL='termite'
export BROWSER='firefox-developer-edition'
export READER='okular'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
