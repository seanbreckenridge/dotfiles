# Set PATH in ~/.profile so that
# rofi/other utilities have access to it
# this is sourced automatically by zsh

PATH="\
${HOME}/.local/bin:\
${HOME}/.local/share/npm-packages/bin:\
${HOME}/.local/scripts/system:\
${HOME}/.local/scripts/bin:\
${HOME}/.local/share/shortcuts:\
${HOME}/.local/share/go/bin:\
${HOME}/.local/share/cargo/bin:\
${HOME}/.local/share/pubcache/bin:\
${HOME}/.gem/ruby/2.7.0/bin:\
${HOME}/.emacs.d/bin:\
${PATH}"
export PATH

# dark theme QT applications
export QT_QPA_PLATFORMTHEME="qt5ct"

# some system wide defaults

# manually set language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Set default applicaitons
export VISUAL='nvim'   # e.g. for edit-command-line in ~/.zshrc, to prompt in current terminal
export EDITOR='editor' # ~/.local/scripts/system/editor, wrapper for picking emacs/nvim for editor
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
export REPOS="${HOME}/code"
export PICTURES="${HOME}/Pictures"
export SCREENSHOTS="${PICTURES}/Screenshots"
export DOWNLOADS="${HOME}/Downloads"
export DOCUMENTS="${HOME}/Documents"
export MOVIES="${HOME}/Movies"
export MUSIC="${HOME}/Music"

