# first dotfile to be loaded - define zsh environment variables

# rest of zsh dotfile configuration
export ZDOTDIR="${HOME}/.config/zsh"

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
