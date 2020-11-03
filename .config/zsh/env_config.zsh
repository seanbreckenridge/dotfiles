# This file sets zsh history configuration
# and environment variables/aliases
# which move config/data files
# for applications to closer
# adhere to the XDG standard
# also sets any environment variables
# for shell tools/applications

# zsh history configuration

HISTFILE="${ZDOTDIR}/.zsh_history"
# https://github.com/zsh-users/zsh/blob/17ee9c5f68d18ef48c1ef99ae6162a06675104f2/Src/zsh.h#L46
HISTSIZE=10000000000000000
SAVEHIST=10000000000000000
setopt APPEND_HISTORY     # append to history file instead of replacing
setopt HIST_REDUCE_BLANKS # delete empty lines from history file
setopt HIST_IGNORE_SPACE  # ignore lines that start with space
setopt HIST_NO_STORE      # Do not add history and fc commands to the history
setopt EXTENDED_HISTORY   # save time/duration to history file

# Set environment variables to change default cache/config file locations

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

# playlist manager: https://github.com/seanbreckenridge/plaintext-playlist
export PLAINTEXT_PLAYLIST_MUSIC_DIR="${MUSIC}"
export PLAINTEXT_PLAYLIST_PLAYLISTS="${XDG_DATA_HOME:-$HOME/.local/share}/plaintext_playlist"

# ignore less history
export LESSHISTFILE="-"

# gnupg
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

# Corrections
# aliases that fix the config/history path of commands
alias irb='ruby "${XDG_CONFIG_HOME}/irbrc"'
alias wget='wget --hsts-file "${XDG_CACHE_HOME}/wget-hsts"'

# general environment variable configuration
export YSU_MESSAGE_FORMAT="$(tput setaf 1)>>> %alias_type: %alias $(tput sgr0)"

# directories that can be cd'd into
export CDPATH="${HOME}:${REPOS}:${HOME}/.config:${HOME}/.local/scripts"

# bat theme
export BAT_THEME="Dracula"

# fzf configuration
export FZF_DEFAULT_OPTS=""
export FZF_DEFAULT_COMMAND="fd -IHL -E .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND -t d"

# colors for manpages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# If on mac, put gnu utils on path before others:
if [[ -z "$ONLINUX" ]]; then
	PATH="\
/usr/local/bin:\
${HOME}/.rbenv/versions/2.7.1/bin:\
${HOME}/Library/Python/3.8/bin:\
/usr/local/opt/coreutils/libexec/gnubin:\
/usr/local/opt/diffutils/bin:\
/usr/local/opt/findutils/libexec/gnubin:\
/usr/local/opt/gawk/libexec/gnubin:\
/usr/local/opt/gnu-indent/libexec/gnubin:\
/usr/local/opt/gnu-sed/libexec/gnubin:\
/usr/local/opt/gnu-tar/libexec/gnubin:\
/usr/local/opt/gnu-which/libexec/gnubin:\
/usr/local/opt/grep/libexec/gnubin:\
/usr/local/opt/gnu-getopt/bin:\
${PATH}\
"
	source "${HOME}/.common_paths"
	export PATH
fi
