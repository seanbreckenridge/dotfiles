#!/usr/bin/env zsh

# This file sets zsh history configuration
# and environment variables/aliases
# which move config/data files
# for applications to closer
# adhere to the XDG standard
# also sets any environment variables
# for shell tools/applications

# zsh history configuration

HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY       # append to history file instead of replacing
setopt HIST_IGNORE_ALL_DUPS # ignore repeated commands
setopt HIST_FIND_NO_DUPS    # dont display if found earlier in history
setopt HIST_IGNORE_DUPS     # ignore rows if they are duplicates
setopt HIST_REDUCE_BLANKS   # delete empty lines from history file
setopt HIST_IGNORE_SPACE    # ignore lines that start with space
setopt HIST_NO_STORE        ## Do not add history and fc commands to the history

# Set environment variables to change defualt cache/config file locations

# Change npm install dir from /usr/local/bin (which requires sudo)
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME}/npm-packages"
export NODE_PATH="${NPM_CONFIG_PREFIX}/lib/node_modules:${NODE_PATH}"

# Go
export GOPATH="${XDG_DATA_HOME}/go"
export GOBIN="${GOPATH}/bin"

# Rust
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

# Elm
export ELM_HOME="${XDG_DATA_HOME}/elm"

# Dart
export PUB_CACHE="${XDG_DATA_HOME}/pubcache"

# Python/Venv related
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
export PIPENV_PYTHON="${PYENV_ROOT}/shims/python"

# Cookiecutter - for pypi projects
export COOKIECUTTER_CONFIG="${XDG_CONFIG_HOME}/cookiecutterrc"

# MySQL History File
export MYSQL_HISTFILE="${XDG_CACHE_HOME}/mysql_history"

# Node History File
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_repl_history"

# save iex (elixir) history
export ERL_AFLAGS="-kernel shell_history enabled"

# move elixir (mix/hex) directories
export MIX_HOME="${XDG_DATA_HOME}/mix"
export HEX_HOME="${XDG_DATA_HOME}/hex"

# Python History File
# set PYTHON_STARTUP python file, which runs when an
# interactive shell is opened
# reads from the history file in ~/.cache/python_history
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/pythonrc"

# move ipython data directory
export IPYTHONDIR="${XDG_DATA_HOME}/ipython"

# SQLite history file
export SQLITE_HISTORY="${XDG_CACHE_HOME}/sqlite_history"

# cube scramble cli history file
export SCRAMBLE_HISTORY="${XDG_CACHE_HOME}/scramble_history"

# ruby: only seems to work for bundle-installed gems
# the rest of the typically installed 'gem install <gem>'
# go to ~/.gem
export GEM_HOME="${XDG_DATA_HOME}/gem"

# julia
export JULIA_DEPOT_PATH="${XDG_DATA_HOME}/julia"

# shortcuts: https://github.com/seanbreckenridge/shortcuts
export SHORTCUTS_DIR="${XDG_DATA_HOME}/shortcuts"

# ignore less history
export LESSHISTFILE="-"

# gnupg
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Corrections
# aliases that fix the config/history path of commands
alias irb='ruby "${XDG_CONFIG_HOME}/irbrc"'
alias wget='wget --hsts-file "${XDG_CACHE_HOME}/wget-hsts"'

# general environment variable configuration
export YSU_MESSAGE_FORMAT="$(tput setaf 1)>>> ALIAS || %alias_type: %alias $(tput sgr0)"
export MPVF_PICKER="rofi"

# colors for manpages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
