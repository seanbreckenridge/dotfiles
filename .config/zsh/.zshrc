# Additional/non-zsh alias/path/function/config

# environment/history configuration

# Change npm install dir from /usr/local/bin (which requires sudo)
# ~/.npmrc should have the contents:  `prefix=${HOME}/.npm-packages`
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="${NPM_PACKAGES}/lib/node_modules:${NODE_PATH}"

# Python/Venv related
export PYENV_ROOT="${HOME}/.pyenv"
export PIPENV_PYTHON="${PYENV_ROOT}/shims/python"

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

# inherit from /etc/manpath and add npm man pages
unset MANPATH
MANPATH="\
${NPM_PACKAGES}/share/man:\
$(manpath)"
export MANPATH

# antigen configuration
source /usr/share/zsh/share/antigen.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle command-not-found
antigen bundle zsh-users/zsh-autosuggestions
antigen apply

# using antigen to install robbyrussel/oh-my-zsh might be nice for the auto updates
# but it causes some weird circular dependencies that make installing it not nice

# some completion features from: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
autoload -Uz compinit  # zsh tab completion
zstyle ':completion:*' menu select  #  http://zsh.sourceforge.net/Guide/zshguide06.html
zmodload zsh/complist  # http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
setopt globdots

# load user defined functions
for func in $(command ls -1 "${ZDOTDIR}/functions/"); do
  autoload -Uz $func
done

# General Aliases
[[ -f  "${ZDOTDIR}/zsh_aliases" ]] && source "${ZDOTDIR}/zsh_aliases"

# Personal Aliases (e.g. ssh to servers)
[[ -f "${ZDOTDIR}/personal_aliases" ]] && source "${ZDOTDIR}/zsh_aliases"

# app specific init
eval $(thefuck --alias)
# powerline
powerline-daemon -q
source /usr/lib/python*/site-packages/powerline/bindings/zsh/powerline.zsh
