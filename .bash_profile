#!/usr/bin/env bash

# bash is usually called from zsh to do some testing, so don't do path configuration

export HISTTIMEFORMAT="%s "
export HISTFILESIZE=-1
export HISTSIZE=-1
shopt -s histappend # dont overwrite history
shopt -s cmdhist    # save al-lines of multi-line commands in the same entry
shopt -s lithist    # embedded newlines for multi-line commands

source_if_exists() {
	# these could have zsh bindings, so ignore errors
	[[ -r "$1" ]] && source "$1" 2>/dev/null
}

ALIAS_DIR="${HOME}/.config/zsh/aliases"
source_if_exists "${ALIAS_DIR}/aliases"
source_if_exists "${ALIAS_DIR}/git_aliases"
source_if_exists "${ALIAS_DIR}/tokens"
source_if_exists "${ALIAS_DIR}/personal_aliases"
source_if_exists "${ALIAS_DIR}/project_aliases"
source_if_exists "${ALIAS_DIR}/lang_aliases"
