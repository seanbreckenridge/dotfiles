# load zsh-completions installed with pacman,
# user defined functions and completions
fpath=("$ZDOTDIR"/functions "$ZDOTDIR"/completions "${fpath[@]}")

# if on linux
if [[ -n "$ONLINUX" ]]; then
	fpath+=(/usr/share/zsh/site-functions)
else
	# on mac
	# if compaudit complains:
	# run:
	# sudo chown -R $(whoami) <folders>...
	fpath+=(/usr/local/share/zsh/site-functions)
fi

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

# bind fzf_select (fuzzy match everything and open/cd to dir in ranger)
bindkey -s '^F' "ranger --cmd='fzf_select'^M"
bindkey -s '^G' "ranger --cmd='chain set show_hidden true; fzf_select_hidden'^M"

# Alt+left arrow/Alt+H to move up a dir
up-dir() {
	cd ".."
	zle reset-prompt
}
zle -N up-dir
bindkey "^[[1;3D" up-dir
bindkey "^[h" up-dir

# Alt+right arrow/Alt+L to launch fzf cd (move into dir)
bindkey "^[[1;3C" fzf-cd-widget
bindkey "^[l" fzf-cd-widget

# Alt+Shift+C to fzf into a directory in my repos
fzf-repos() {
	cd "$REPOS"
	fzf-cd-widget
	# if user didnt select a dir to cd into
	# and is still in Repos, go back to
	# the dir they were in previously
	if [[ "$PWD" == "$REPOS" ]]; then
		cd "$OLDPWD"
	fi
	zle reset-prompt
}
zle -N fzf-repos
bindkey "^[C" fzf-repos

# ^u is Ctrl+U, which is bound to
# to kill-whole-line
# this means that Alt+R deletes everything at
# the current prompt, types ranger, and then sends a newline
# this is done since ranger requires it to be run
# from the terminal and can't be done from a function or (zle -N)
# See <https://unix.stackexchange.com/a/595281/282432>

# Alt+R to launch ranger (file manager)
bindkey -s "^[r" "^uranger^M"

# Alt+F to rg-nvim
f-rg-nvim() {
	rg-nvim "$@"
}
zle -N f-rg-nvim
bindkey "^[f" f-rg-nvim
