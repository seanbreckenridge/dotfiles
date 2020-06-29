# Setup my prompt and built-in keybindings

# setup prompt
parse_git_branch() {
	local BRANCH_NAME
	BRANCH_NAME="$(git symbolic-ref --short HEAD 2>/dev/null)"
	(($? == 0)) && echo -n " | %{%F{green}%}${BRANCH_NAME}%{%F{none}%}\n"
}

setopt PROMPT_SUBST
PROMPT='[ %9c$(parse_git_branch) ] $ '

# Change cursor shape for different vi modes.
function zle-keymap-select() {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'

	elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} = '' ]] ||
		[[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select

zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne "\e[5 q"
}
zle -N zle-line-init

# vim style bindings
# Escape to enter command mode
export KEYTIMEOUT=1
bindkey -v
bindkey -v '^?' backward-delete-char # allow backspace to delete items after exiting command mode

# basic readline bindings
bindkey '^A' vi-beginning-of-line
bindkey '^E' vi-end-of-line
bindkey '^K' vi-kill-eol

# press space in vi command mode
# to open current command in a vimbuffer
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line
