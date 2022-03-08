# redefine function if it doesnt exist
hash source_if_exists 2>/dev/null || {
	source_if_exists() {
		if [[ -r "$1" ]]; then
			source "$1"
		else
			[[ -z "$SQ" ]] && printf "Could not source %s\n" "$1"
			return 1
		fi
	}
}

ALIAS_DIR="${ZDOTDIR}/aliases"
source "${ALIAS_DIR}/aliases"         # General aliases
source "${ALIAS_DIR}/git_aliases"     # Git aliases (from oh-my-zsh)
source "${ALIAS_DIR}/project_aliases" # Aliases for my own projects
source "${ALIAS_DIR}/lang_aliases"    # language/programming aliases
# Personal Aliases (e.g. ssh to servers)
SQ=1 source_if_exists "${ALIAS_DIR}/personal_aliases" || SQ=1 source_if_exists "${HPIDATA}/personal_aliases"
# Tokens for interacting with APIs etc
SQ=1 source_if_exists "${ALIAS_DIR}/tokens" || SQ=1 source_if_exists "${HPIDATA}/tokens"
