#!/usr/bin/zsh

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
compdef _gnu_generic exists youtube-dl wait-for-internet genpasswd genpass shortcuts dragon-drag-and-drop tiv dust highlight ranger rifle scrot keepassxc
compdef _binary_completion which-cat launch
compdef _editor e

# bind fzf-edit (fuzzy match everything and open/cd to dir)
zle -N fzf-edit; bindkey '^F' fzf-edit
# fuzzy match everything (including hidden files)
fzf-edit-hidden() { fzf-edit -H }
zle -N fzf-edit-hidden; bindkey '^G' fzf-edit-hidden

# Alt+left arrow/Alt+H to move up a dir
up-dir() { cd ".."; zle reset-prompt }; zle -N up-dir
bindkey "^[[1;3D" up-dir
bindkey "^[h" up-dir

# Alt+right arrow/Alt+L to launch fzf cd (move into dir)
bindkey "^[[1;3C" fzf-cd-widget
bindkey "^[l" fzf-cd-widget

# Ctrl+P to plainplay (playlist manager/music player)
# https://github.com/seanbreckenridge/plaintext-playlist
bindkey -s '^P' "plainplay\n"

# Alt+Shift+C to fzf into a directory in ~/code
fzf-code() {
  cd "$HOME/code"
  fzf-cd-widget
  # if user didnt select a dir to cd into
  # and is still in ~/code, go back to
  # the dir they were in previosuly
  if [ "$PWD" = "$HOME/code" ]; then
    cd "$OLDPWD"
  fi
  zle reset-prompt
}
zle -N fzf-code
bindkey "^[C" fzf-code

# Alt+R to launch ranger (file manager)
bindkey -s "^[r" "ranger\n"

# Alt+X to run xmodmap (to rebind keys on external keyboards)
bindkey -s "^[x" "xmodmap ~/.Xmodmap 2>/dev/null\n"

# fzf
# ctrl t to autocomplete files from cwd
# ctrl r to fuzzy match through command history
# alt c to cd to fuzzy matched directory
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_OPTS=""
export FZF_DEFAULT_COMMAND="fd -H -L"  # ignore files in gitignore
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND -t d -E .git"

# zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
