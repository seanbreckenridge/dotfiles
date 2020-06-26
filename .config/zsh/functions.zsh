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

# Alt+Shift+R to launch ranger and fzf_select
bindkey -s "^[R" "ranger --cmd=fzf_select\n"

# Alt+X to run xmodmap (to rebind keys on external keyboards)
bindkey -s "^[x" "xmodmap ~/.Xmodmap 2>/dev/null\n"
