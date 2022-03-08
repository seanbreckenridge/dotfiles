#!/usr/bin/env bash

# bash is usually called from zsh to do some testing, so don't do path configuration

export HISTTIMEFORMAT="%s "
export HISTFILESIZE=-1
export HISTSIZE=-1
shopt -s histappend # dont overwrite history
shopt -s cmdhist    # save al-lines of multi-line commands in the same entry
shopt -s lithist    # embedded newlines for multi-line commands

source "${HOME}/.config/zsh/source_aliases.zsh" 2>/dev/null
