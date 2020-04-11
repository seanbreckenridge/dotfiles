#!/usr/bin/env zsh
# source each zsh config file

source "${ZDOTDIR}/history_config.zsh" # History/Application configuration
source "${ZDOTDIR}/prompt.zsh"         # prompt configuration
source "${ZDOTDIR}/zsh_aliases"        # General aliases
source "${ZDOTDIR}/git_aliases"        # Git aliases (from oh-my-zsh)
source "${ZDOTDIR}/personal_aliases"   # Personal Aliases (e.g. ssh to servers)
source "${ZDOTDIR}/directory_aliases"  # Directory Aliases (shortcuts to jump to directories)
source "${ZDOTDIR}/functions.zsh"      # functions, bindings, completions
source "${ZDOTDIR}/lazy.zsh"           # lazy load shell tools
