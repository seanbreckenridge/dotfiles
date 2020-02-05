# Additional zsh/alias/path/function/config

source "${HOME}/.profile"

# Set color scheme (pywal) in the background
(cat ~/.cache/wal/sequences &)

# prompt/completion features from: https://github.com/LukeSmithxyz/voidrice/blob/master/.config/zsh/.zshrc
autoload -U colors && colors
export PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# load zsh-completions installed with pacman to (among other things) allow menu select w/ highlight
# load user defined zsh functions
fpath=(
  /usr/share/zsh/site-functions
  "$ZDOTDIR/functions"
  "${fpath[@]}"
)

autoload -Uz "$ZDOTDIR/functions"/*

zmodload zsh/complist  # http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
zstyle ':completion:*' menu select  #  http://zsh.sourceforge.net/Guide/zshguide06.html
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Auto complete with case insenstivity

# Note: tried caching the result to compinit, using
# zcompudmp (which calls compaudit)
# to speed up start times by caching zcompdump,
# ends up taking longer. Difference is resonable,
# about ~0.1s. longer. This may change as zcompdump
# size increases
#
autoload -Uz compinit && compinit
# allow autocompletion to target hidden files
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

# bind zsh functions to key bindings
# enter vi cmd mode, then use ctrl+letter
zle -N fzffd
bindkey -M vicmd '^f' fzffd

zle -N fzfedit
bindkey -M vicmd '^e' fzfedit

zle -N fkill
bindkey -M vicmd '^k' fkill

source "${ZDOTDIR}/zsh_aliases"

# Git aliases (from oh-my-zsh)
source "${ZDOTDIR}/git_aliases"

# Personal Aliases (e.g. ssh to servers)
source "${ZDOTDIR}/personal_aliases"

# Directory Aliases (shortcuts to jump to directories)
source "${ZDOTDIR}/directory_aliases"

# lazy load
fuck() {
  eval $(thefuck --alias)  # redefines the function
  fuck "$@"
}

# fzf
# ctrl t to autocomplete files from cwd
# ctrl r to fuzzy match through command history
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="--extended"
export FZF_DEFAULT_COMMAND="fd -L"  # ignore files in gitignore
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh

