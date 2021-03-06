#!/bin/sh
# global configuration/environment
# this is sourced in .xinitrc (when I run startx) on Linux and
# from ~/.zshenv on other operating systems
# mac (see ~/.config/yadm/mac_bootstrap for the generated .zshenv)

# Directories

## XDG
export XDG_DOWNLOAD_DIR="${HOME}/Downloads"
export XDG_DOCUMENTS_DIR="${HOME}/Documents"
export XDG_PICTURES_DIR="${HOME}/Pictures"
export XDG_VIDEOS_DIR="${HOME}/Movies"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export REPOS="${HOME}/Repos"

# set global OS environment variable
# used in lots of my scripts
# and in my bootstrap/installation process
# to choose how to install everything
case "$(uname -s)" in
Linux*)
	if command -v termux-setup-storage >/dev/null 2>&1; then
		ON_OS='android'
	else
		# check if we're in WSL
		case "$(uname -r)" in
		*Microsoft*)
			ON_OS='windows'
			# get the windows home directory, something like
			# /mnt/c/Users/Name
			WHOME_FILE="${HOME}/.cache/whome"
			if [[ ! -f "${WHOME_FILE}" ]]; then
				wslpath "$(wslvar USERPROFILE)" >"${WHOME_FILE}"
			fi
			export WHOME="$(cat "${WHOME_FILE}")"
			;;
		*)
			ON_OS='linux'
			;;
		esac
	fi
	;;
Darwin*)
	ON_OS='mac'
	;;
*)
	printf "Unknown Operating System...\n"
	uname -s
	uname -r
	;;
esac

export ON_OS

# common path modifications
PATH="\
${HOME}/.local/share/shortcuts:\
${HOME}/.local/bin:\
${HOME}/.local/share/npm-packages/bin:\
${HOME}/.local/scripts/mac:\
${HOME}/.local/scripts/cross-platform:\
${HOME}/.local/scripts/generic:\
${HOME}/.local/share/go/bin:\
${HOME}/.local/share/cargo/bin:\
${HOME}/.local/share/pubcache/bin:\
${HOME}/.emacs.d/bin:\
${HOME}/.cabal/bin:\
${HOME}/.config/i3blocks/blocks:\
${PATH}"

# https://github.com/seanbreckenridge/HPI
# the 'root data directory' for HPI
HPIDATA="${HOME}/data"

# defaults, some of these are overwrriten in the case below
XDG_MUSIC_DIR="${HOME}/Music"
BROWSER='firefox-developer-edition'
SCREENSHOTS="${XDG_PICTURES_DIR}/Screenshots"

# overwrite some envvars with OS-specific data
case "$ON_OS" in
linux)
	PATH="${HOME}/.gem/ruby/2.7.0/bin:${HOME}/.local/scripts/linux:${PATH}" # add linux scripts to $PATH
	export ARCHFLAGS="-arch x86_64"                                         # Compilation flags
	;;
mac)
	SCREENSHOTS="${HOME}/Desktop" # Screenshots on Mac are saved on the Desktop
	;;
android)
	HPIDATA="${HOME}/storage/shared/data"
	XDG_MUSIC_DIR="${HOME}/storage/music/"
	figlet termux
	;;
windows)
	BROWSER='/mnt/c/Program Files/Mozilla Firefox/firefox.exe'
	;;
esac

export HPIDATA BROWSER XDG_MUSIC_DIR PATH SCREENSHOTS
export PLAINTEXT_PLAYLIST_PLAYLISTS="${HPIDATA}/playlists"

# some system wide defaults

# manually set language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Set default applications
export VISUAL='nvim'   # e.g. for edit-command-line in ~/.zshrc, to prompt in current terminal
export EDITOR='editor' # ~/.local/scripts/cross-platform/editor, wrapper for picking emacs/nvim for editor
export PAGER='less'
export TERMINAL='alacritty'
export READER='okular'

# define where ZDOTDIR (rest of zsh configuration) is
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# helper envvar to be used in names of files
SHELL_BOOT_TIME="$(date '+%s')"
export SHELL_BOOT_TIME

# variables which ideally should be sourced into the global
# environment since they could be referenced without opening a terminal
# e.g. from my menu bar/window manager/run launcher
# https://github.com/seanbreckenridge/ttally
export TTALLY_DATA_DIR="${HPIDATA}/ttally"
# https://github.com/seanbreckenridge/ttt
export TTT_HISTFILE="${HPIDATA}/ttt/${SHELL_BOOT_TIME}.csv"
export URL_CACHE_DIR="${HPIDATA}/url_cache"
# playlist manager: https://github.com/seanbreckenridge/plaintext-playlist
export PLAINTEXT_PLAYLIST_MUSIC_DIR="${XDG_MUSIC_DIR}"
export IPGEOCACHE_DIR="${HPIDATA}/ipgeocache"
export TODO_DIR="${HPIDATA}/todo" # todo.txt
