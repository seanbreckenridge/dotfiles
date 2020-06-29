#!/bin/sh
# global configuration/environment
# this is sourced by the lightdm on Linux and
# from ~/.zshenv on mac (see ~/.config/yadm/mac_bootstrap)

[ "$(uname -s)" = "Linux" ] && export ONLINUX=1
# ~/.profile is sourced before ~/.xprofile, so use uname to determine if we're on Mac/Linux
# see /etc/lightdm/Xsession
if [ -n "$ONLINUX" ]; then
  # source common_paths for shared (mac/linux) path modifications
  . "${HOME}/.common_paths"
  export PATH
fi

# dark theme QT applications
export QT_QPA_PLATFORMTHEME="qt5ct"

# some system wide defaults

# manually set language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Set default applicaitons
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

# Directories
export REPOS="${HOME}/Repos"
export PICTURES="${HOME}/Pictures"
export SCREENSHOTS="${PICTURES}/Screenshots"
export DOWNLOADS="${HOME}/Downloads"
export DOCUMENTS="${HOME}/Documents"
export MOVIES="${HOME}/Movies"
export MUSIC="${HOME}/Music"

