# Additional/non-zsh alias/path/function/config

[[ -f "${HOME}/.profile" ]] && source "${HOME}/.profile"

# Set color scheme (pywal) in the background
(cat ~/.cache/wal/sequences &)

# prompt/completion features from: https://github.com/LukeSmithxyz/voidrice/blob/master/.config/zsh/.zshrc
autoload -U colors && colors
export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

autoload -Uz compinit  # zsh tab completion
zstyle ':completion:*' menu select  #  http://zsh.sourceforge.net/Guide/zshguide06.html
zmodload zsh/complist  # http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
setopt globdots

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

# antigen
source /usr/share/zsh/share/antigen.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle djui/alias-tips
antigen apply

# vim style bindings
# Escape to enter command mode
export KEYTIMEOUT=1
bindkey -v
# basic emacs bindings
bindkey '^A' vi-beginning-of-line
bindkey '^E' vi-end-of-line
bindkey '^K' vi-kill-eol

# load user defined functions
for func in $(command ls -1 "${ZDOTDIR}/functions/"); do
  autoload -Uz $func
done

source "${ZDOTDIR}/zsh_aliases"

# Git aliases (from oh-my-zsh)
source "${ZDOTDIR}/git_aliases"

# Personal Aliases (e.g. ssh to servers)
[[ -f "${ZDOTDIR}/personal_aliases" ]] && source "${ZDOTDIR}/personal_aliases"

# application environment/history configuration

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

# ruby
export GEM_HOME="${HOME}/.gem"

# shortcuts: https://github.com/seanbreckenridge/shortcuts
export SHORTCUTS_DIR="${HOME}/.local/shortcuts"

# app specific init
eval $(thefuck --alias)

