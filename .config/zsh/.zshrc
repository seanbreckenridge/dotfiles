#!/bin/zsh

# helper to optionally source files
# if -q is passed as an option, this doesnt complain if the file isnt readable
# otherwise, this warns
source_if_exists() {
	local quiet
	quiet=0
	while getopts 'q' opt; do
		case "$opt" in
		q)
			quiet=1
			;;
		*) ;;
		esac
	done
	shift "$((OPTIND - 1))"
	if [[ -r "$1" ]]; then
		source "$1"
	else
		if ! ((quiet)); then
			printf "Could not source %s\n" "$1"
		fi
		return 1
	fi
}

# source each zsh config file
# source zsh config
source "${ZDOTDIR}/env_config.zsh"              # History/Application configuration
source "${ZDOTDIR}/prompt.zsh"                  # prompt configuration
source "${ZDOTDIR}/functions.zsh"               # functions, bindings, command completion
source "${ZDOTDIR}/cd.zsh"                      # functions to change my directory
source "${ZDOTDIR}/completion.zsh"              # zsh completion
source "${ZDOTDIR}/lazy.zsh"                    # lazy load shell tools
source "${ZDOTDIR}/progressive_enhancement.zsh" # slightly improve commands
source "${ZDOTDIR}/updates.zsh"                 # update globally installed lang-specific packages
source "${ZDOTDIR}/hpi.zsh"                     # handle syncing hpi config
source "${ZDOTDIR}/ssh.zsh"                     # create a ssh-agent socket

# source all aliases
source "${ZDOTDIR}/source_aliases.zsh"

# the 'u' alias runs periodic jobs, depending on the OS
alias u='rj'
# zsh plugins
case "$ON_OS" in
linux*)
	# add flatpak to $PATH. It already adds itself to XDG_USER_DIRS (which is picked up by rofi)
	# in /etc/profile.d/flatpak.sh but that doesn't let me launch it from my terminal
	export PATH="/var/lib/flatpak/exports/bin:${PATH}"
	# fzf
	source_if_exists /usr/share/fzf/key-bindings.zsh
	source_if_exists /usr/share/fzf/completion.zsh
	# other plugins
	source_if_exists /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	asdf-enable() {
		source_if_exists /opt/asdf-vm/asdf.sh
	}
	source "${ZDOTDIR}/linux.zsh"
	function linux_updates() {
		housekeeping-offline
		rj
		true
	}
	alias u=linux_updates
	;;
mac*)
	# Setup fzf
	# ---------
	if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
		export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
	fi
	# Auto-completion
	[[ $- == *i* ]] && source_if_exists "/usr/local/opt/fzf/shell/completion.zsh" 2>/dev/null
	# Key bindings
	source_if_exists "/usr/local/opt/fzf/shell/key-bindings.zsh"
	# Other plugins
	source_if_exists /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	source_if_exists /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source_if_exists /usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh
	source "${ZDOTDIR}/mac.zsh"
	;;
android*)
	source_if_exists "${HOME}/../usr/share/fzf/key-bindings.zsh"
	source_if_exists "${HOME}/../usr/share/fzf/completion.zsh"

	source_if_exists "${HOME}/.local/share/zsh_plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
	source "${ZDOTDIR}/android.zsh"
	alias u=syncfiles
	;;
windows*)
	source_if_exists /usr/share/doc/fzf/examples/completion.zsh
	source_if_exists /usr/share/doc/fzf/examples/key-bindings.zsh
	source "${ZDOTDIR}/windows.zsh"
	;;
esac

source_if_exists "${XDG_DATA_HOME}/basher/cellar/packages/rupa/z/z.sh"

# override the CTRL+R widget using my hpi zsh history
source_if_exists "${REPOS}/HPI-personal/scripts/fzf_history_widget.zsh"

havecmd basher && eval "$(basher init - zsh)"

source "${ZDOTDIR}/cache_aliases.zsh"
true
