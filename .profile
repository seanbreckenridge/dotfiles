#!/bin/sh
# global configuration/environment
# this is sourced by the lightdm on Linux and
# from ~/.zshenv on mac (see ~/.config/yadm/mac_bootstrap)

# Directories
export REPOS="${HOME}/Repos"
export PICTURES="${HOME}/Pictures"
export DOWNLOADS="${HOME}/Downloads"
export DOCUMENTS="${HOME}/Documents"
export MOVIES="${HOME}/Movies"
export MUSIC="${HOME}/Music"

# see /etc/lightdm/Xsession
[ "$(uname -s)" = "Linux" ] && export ONLINUX=1

if [ -n "$ONLINUX" ]; then
	# source common_paths for shared (mac/linux) path modifications
	. "${HOME}/.common_paths"
	PATH="${HOME}/.gem/ruby/2.7.0/bin:${PATH}"
	export PATH
	export SCREENSHOTS="${PICTURES}/Screenshots"
else
	# Screenshots on Mac are saved on the Desktop
	export SCREENSHOTS="${HOME}/Desktop"
fi

# some system wide defaults

# manually set language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Set default applications
export VISUAL='nvim'   # e.g. for edit-command-line in ~/.zshrc, to prompt in current terminal
export EDITOR='editor' # ~/.local/scripts/cross-platform/editor, wrapper for picking emacs/nvim for editor
export PAGER='less'
export TERMINAL='alacritty'
export BROWSER='firefox-developer-edition'
export READER='okular'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# XDG user dirs
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

# define where ZDOTDIR (rest of zsh configuration) is
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# variables which ideally should be sourced into the global
# environment since they could be referenced without opening a terminal
# e.g. from my menu bar/window manager/run launcher
# https://github.com/seanbreckenridge/tupletally
export TUPLETALLY_DATA_DIR="${HOME}/data/tupletally"
# https://github.com/seanbreckenridge/ttt
export TTT_HISTFILE="${HOME}/data/ttt/$(date '+%s').csv"
