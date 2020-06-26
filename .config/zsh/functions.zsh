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

# ^u is Ctrl+U, which is bound to
# to kill-whole-line
# this means that Alt+R deletes everything at
# the current prompt, types ranger, and then sends a newline
# this is done since ranger requires it to be run
# from the terminal and can't be done from a function or (zle -N)
# See <https://unix.stackexchange.com/a/595281/282432>

# Alt+R to launch ranger (file manager)
bindkey -s "^[r" "^uranger^M"

# Alt+Shift+R to launch ranger and fzf_select
bindkey -s "^[R" "^uranger --cmd=fzf_select^M"

# Alt+X to run xmodmap (to rebind keys on external keyboards)
bindkey -s "^[x" "^uxmodmap ~/.Xmodmap 2>/dev/null^M"
