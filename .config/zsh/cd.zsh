# bindings to change my directory in the shell
#
# Alt+left arrow/Alt+H to move up a dir
up-dir() {
	cd '..'
	zle reset-prompt
}
zle -N up-dir
bindkey '^[[1;3D' up-dir
bindkey '^[h' up-dir

# Alt+right arrow/Alt+L to launch fzf cd (move into dir)
bindkey '^[[1;3C' fzf-cd-widget
bindkey '^[l' fzf-cd-widget
