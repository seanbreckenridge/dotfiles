#!/usr/bin/env zsh

# load zsh-completions installed with pacman,
# user defined functions and completions
fpath=(/usr/share/zsh/site-functions "$ZDOTDIR"/functions "$ZDOTDIR"/completions "${fpath[@]}")

# autoload must be after modifying fpath to auto-load completions

# -U ignores alias/shell expansion
# -z forches zsh style autoloading over ksh, if thats set for some reason
autoload -Uz compinit && compinit

# Note: tried caching the result to compinit, using
# zcompudmp (which calls compaudit)
# to speed up start times by caching zcompdump,
# ends up taking longer. Difference is resonable,
# about ~0.1s. longer. This may change as zcompdump
# size increases

# lazy-load user defined functions
autoload -Uz "$ZDOTDIR"/functions/*

# personal zsh completions
autoload -Uz "$ZDOTDIR"/completions/*
compdef _binary_completion which-cat launch
compdef _editor e

# bind fzfedit (fuzzy match everything and open/cd to dir)
zle -N fzfedit
bindkey '^F' fzfedit

# Alt+left arrow/Alt+L to move up a dir
up-dir() { cd ".."; zle reset-prompt }; zle -N up-dir
bindkey "^[[1;3D" up-dir
bindkey "^[h" up-dir

# Alt+right arrow/Alt+H to launch fzf cd
bindkey "^[[1;3C" fzf-cd-widget
bindkey "^[l" fzf-cd-widget

# Alt+Shift+C to fzf into a directory in ~/code
fzf-code() { cd "$HOME/code"; fzf-cd-widget && zle reset-prompt }; zle -N fzf-code
bindkey "^[C" fzf-code

# Alt+R to launch ranger (file manager)
bindkey -s "^[r" "ranger\n"

# fzf
# ctrl t to autocomplete files from cwd
# ctrl r to fuzzy match through command history
# alt c to cd to fuzzy matched directory
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS="--extended"
export FZF_DEFAULT_COMMAND="fd -H -L"  # ignore files in gitignore
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND -t d -E .git"

# zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh
source "${GOPATH}/src/github.com/sei40kr/zsh-fast-alias-tips/fast-alias-tips.plugin.zsh"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
