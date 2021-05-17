#!/usr/bin/env zsh
# periodically cache my aliases so I can reconstruct the meaning of commands using them
# should be the last thing run when starting zsh
# meant to be used as part of HPI https://github.com/seanbreckenridge/HPI

hash evry && evry 1 week -zsh_alias_cache && {
	ALIAS_CACHE_BACKUP_DIR="$(python3 -m my.utils.backup_to 'zsh_aliases')" || exit $?
	mkdir -p "${ALIAS_CACHE_BACKUP_DIR}"
	ALIAS_CACHE_TARGET="${ALIAS_CACHE_BACKUP_DIR}/$(date +'%s')-$(uname)"
	alias >"${ALIAS_CACHE_TARGET}"
	unset ALIAS_CACHE_BACKUP_DIR ALIAS_CACHE_TARGET
}
