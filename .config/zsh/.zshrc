# Additional/non-zsh alias/path/function/config

[[ -f "${HOME}/.profile" ]] && source "${HOME}/.profile"

# Set color scheme (pywal) in the background
(cat ~/.cache/wal/sequences &)

# prompt/completion features from: https://github.com/LukeSmithxyz/voidrice/blob/master/.config/zsh/.zshrc
autoload -U colors && colors
export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

autoload -Uz compinit  # zsh tab completion
zstyle ':completion:*' menu select  #  http://zsh.sourceforge.net/Guide/zshguide06.html
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Auto complete with case insenstivity
zmodload zsh/complist  # http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
setopt globdots

# load user defined functions
for func in $(command ls -1 "${ZDOTDIR}/functions/"); do
  autoload -Uz $func
done

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# inherit from /etc/manpath and add npm man pages
unset MANPATH
MANPATH="\
${NPM_PACKAGES}/share/man:\
$(manpath)"
export MANPATH

# vim style bindings
# Escape to enter command mode
export KEYTIMEOUT=1
bindkey -v
bindkey -v '^?' backward-delete-char  # allow backspace to delete items after exiting command mode
# basic emacs bindings
bindkey '^A' vi-beginning-of-line
bindkey '^E' vi-end-of-line
bindkey '^K' vi-kill-eol

# press space in vi command mode
# to open current command in a vimbuffer
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line

# bind zsh functions to zle keymaps
zle -N fzffd
bindkey '^F' fzffd

source "${ZDOTDIR}/zsh_aliases"

# Git aliases (from oh-my-zsh)
source "${ZDOTDIR}/git_aliases"

# Personal Aliases (e.g. ssh to servers)
[[ -f "${ZDOTDIR}/personal_aliases" ]] && source "${ZDOTDIR}/personal_aliases"

# Directory Aliases (shortcuts to jump to directories)
[[ -f "${ZDOTDIR}/directory_aliases" ]] && source "${ZDOTDIR}/directory_aliases"

# application environment/history configuration

# XDG user dirs

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

# Change npm install dir from /usr/local/bin (which requires sudo)
# ~/.npmrc should have the contents:  `prefix=${HOME}/.npm-packages`
export NPM_PACKAGES="${HOME}/.npm-packages"
export NODE_PATH="${NPM_PACKAGES}/lib/node_modules:${NODE_PATH}"

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

# zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh

# thefuck to correct commands
eval $(thefuck --alias)

# fzf
# ctrl t to autocomplete files from cwd
# ctrl r to fuzzy match through command history
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="--extended"
export FZF_DEFAULT_COMMAND="fd -L"  # ignore files in gitignore
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

