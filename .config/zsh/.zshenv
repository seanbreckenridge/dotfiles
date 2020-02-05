# first dotfile to be loaded - define zsh environment variables

# rest of zsh dotfile configuration
export ZDOTDIR="${HOME}/.config/zsh"

# locations for additional functons
export fpath=( "${ZDOTDIR}/functions" ${fpath[@]} )

### HISTORY SETTINGS ###

HISTFILE="${ZDOTDIR}/zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory

# History Control: Omit duplicate and commands that begin with a space
export HISTCONTROL='ignoreboth';

# manually set language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Set default applicaitons

export EDITOR='nvim'
export PAGER='less'
export TERMINAL='st'
export BROWSER='firefox-developer-edition'
export READER='okular'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# application environment/history configuration

# XDG user dirs

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

# Change npm install dir from /usr/local/bin (which requires sudo)
# ~/.npmrc should have the contents:  `prefix=${HOME}/.npm-packages`
export NPM_PACKAGES="${HOME}/.npm-packages"
export NODE_PATH="${NPM_PACKAGES}/lib/node_modules:${NODE_PATH}"

# Go
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"

# Python/Venv related
export PYENV_ROOT="${HOME}/.pyenv"
export PIPENV_PYTHON="${PYENV_ROOT}/shims/python"

# Cookiecutter - for pypi projects
export COOKIECUTTER_CONFIG="${HOME}/.config/cookiecutterrc"

# MySQL History File
export MYSQL_HISTFILE="${HOME}/.cache/mysql_history"

# Node History File
export NODE_REPL_HISTORY="${HOME}/.cache/node_repl_history"

# Python History File
# set PYTHON_STARTUP python file, which runs when an
# interactive shell is opened
# reads from the history file in ~/.cache/python_history
export PYTHONSTARTUP="${HOME}/.config/pythonrc"

# SQLite history file
export SQLITE_HISTORY="${HOME}/.cache/sqlite_history"

# cube scramble cli history file
export SCRAMBLE_HISTORY="${HOME}/.cache/scramble_history"

# ruby
export GEM_HOME="${HOME}/.gem"

# shortcuts: https://github.com/seanbreckenridge/shortcuts
export SHORTCUTS_DIR="${HOME}/.local/shortcuts"

# colors for manpages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
