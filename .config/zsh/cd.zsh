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

# uses
# https://github.com/seanbreckenridge/HPI
# https://github.com/seanbreckenridge/ttt
# https://github.com/seanbreckenridge/evry
# https://github.com/seanbreckenridge/fzfcache
# https://github.com/seanbreckenridge/exists
# https://github.com/seanbreckenridge/chomp
#
# cd to some directory I use often
# this generates/orders directories to jump
# to, primarily using https://github.com/seanbreckenridge/ttt
# and a bunch of other shell tools to cache to speedup
# load time
#
# see
# https://sean.fish/d/jumplist?dark
# https://sean.fish/d/tttlist?dark
CD() {
	local chosen
	chosen="$(fzfcache jumplist | fzf --height "${FZF_TMUX_HEIGHT:-50%}" --reverse -i "$@")" || return $?
	cd "${chosen}" || return $?
}

CD-Repos() {
	CD -q "${REPOS} "
}
