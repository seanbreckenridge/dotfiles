# binding to change my directory in the shell
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

# uses
# https://github.com/seanbreckenridge/HPI
# https://github.com/seanbreckenridge/ttt
# https://github.com/seanbreckenridge/evry
# https://github.com/seanbreckenridge/fzfcache
# https://github.com/seanbreckenridge/exists
# https://github.com/seanbreckenridge/chomp
#
# cd to some repo I use commonly
# https://sean.fish/d/jumplist?dark
CD() {
	local chosen
	chosen="$(fzfcache jumplist | fzf --height "${FZF_TMUX_HEIGHT:-50%}" --reverse -i "$@")" || return $?
	cd "${chosen}" || return $?
}

CD-Repos() {
	CD -q "${REPOS} "
	zle reset-prompt
}
zle -N CD-Repos

# Alt+Shift+C to fzf into something in my ~/Repos, sorted by most used
bindkey '^[C' CD-Repos
bindkey -s '^[R' '^uCD && R^M' # CD and open in ranger
