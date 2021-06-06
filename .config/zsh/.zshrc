#!/bin/zsh
# source each zsh config file

source_if_exists() {
	if [[ -r "$1" ]]; then
		source "$1"
	else
		printf "Could not source %s\n" "$1"
	fi
}

# source zsh config
source "${ZDOTDIR}/env_config.zsh"              # History/Application configuration
source "${ZDOTDIR}/prompt.zsh"                  # prompt configuration
source "${ZDOTDIR}/functions.zsh"               # functions, bindings, command completion
source "${ZDOTDIR}/completion.zsh"              # zsh completion
source "${ZDOTDIR}/lazy.zsh"                    # lazy load shell tools
source "${ZDOTDIR}/progressive_enhancement.zsh" # slightly improve commands

# source aliases
ALIAS_DIR="${ZDOTDIR}/aliases"
source "${ALIAS_DIR}/aliases"                    # General aliases
source "${ALIAS_DIR}/git_aliases"                # Git aliases (from oh-my-zsh)
source "${ALIAS_DIR}/other_aliases"              # Aliases for my own projects
source_if_exists "${ALIAS_DIR}/personal_aliases" # Personal Aliases (e.g. ssh to servers)
source_if_exists "${ALIAS_DIR}/tokens"           # Tokens for interacting with APIs etc

# zsh plugins
case "$ON_OS" in
linux)
	# fzf
	source_if_exists /usr/share/fzf/key-bindings.zsh
	source_if_exists /usr/share/fzf/completion.zsh
	# other plugins
	source_if_exists /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	source_if_exists /usr/share/doc/pkgfile/command-not-found.zsh
	source_if_exists /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
	source_if_exists /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	;;
mac)
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
	source "${ZDOTDIR}/mac.zsh"
	;;
android)
	source_if_exists "${HOME}/../usr/share/fzf/key-bindings.zsh"
	source_if_exists "${HOME}/../usr/share/fzf/completion.zsh"
	source "${ZDOTDIR}/android.zsh"
	;;
windows)
	source_if_exists /usr/share/doc/fzf/examples/completion.zsh
	source_if_exists /usr/share/doc/fzf/examples/key-bindings.zsh
	source "${ZDOTDIR}/windows.zsh"
esac

source "${ZDOTDIR}/alias_cache.zsh"
