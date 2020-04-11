# first dotfile to be loaded - define zsh environment variables

# rest of zsh dotfile configuration
export ZDOTDIR="${HOME}/.config/zsh"

# locations for additional functons
export fpath=( "${ZDOTDIR}/functions" ${fpath[@]} )

### HISTORY SETTINGS ###

HISTFILE="${ZDOTDIR}/zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory

# History Control: Omit duplicate and commands that begin with a space
export HISTCONTROL='ignoreboth';

# manually set language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Set default applicaitons

export VISUAL='nvim' # e.g. for edit-command-line in ~/.zshrc, to prompt in current terminal
export EDITOR='editor' # created in ~/.config/shortcuts.toml, wrapper for nvim/emacsclient
export PAGER='less'
export TERMINAL='alacritty'
export BROWSER='firefox-developer-edition'
export READER='okular'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# application environment/history configuration

# XDG user dirs

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

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

# colors for manpages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
