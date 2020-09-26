### zsh completion

# allow menu select w/ highlight
zmodload zsh/complist              # http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
zstyle ':completion:*' menu select #  http://zsh.sourceforge.net/Guide/zshguide06.html
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' \
	'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Auto complete with case insenstivity
setopt globdots                   # allow autocompletion to target hidden files
setopt glob_complete              # wildcard completion, e.g. *.png
setopt completealiases            # expand aliases before completing
setopt autocd                     # automatically cd into directories

# from gotbletu
# https://github.com/gotbletu/dotfiles_v2/blob/master/normal_user/zshrc/.zshrc
# better killall completion
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'
# when new programs is installed, auto update autocomplete without reloading shell
zstyle ':completion:*' rehash true
# Don't complete stuff already on the line
zstyle ':completion::*:(rm|nvim|e|ls):*' ignore-line true

# if ^Xa or tab is hit when over an alias, expand into the alias contents
#bindkey "^Xa" _expand_alias
#zstyle ':completion:*' completer _expand_alias _complete _ignored
#zstyle ':completion:*' regular true

### command completion
# note: this file has to be loaded after functions.zsh
# because else compinit hasnt been loaded to automatically
# assign completions from $ZDOTDIR/completions

autoload -Uz "$ZDOTDIR"/completions/*
compdef _gnu_generic exists youtube-dl wait-for-internet genpasswd genpass shortcuts dragon-drag-and-drop chafa dust highlight ranger rifle scrot keepassxc newsboat mpvf full_todotxt calcurse gifsicle boxes chafa datamash dex glow pup toilet termdown
# manually source playlist file because top compdef declaration doesnt match alias names; autoload wont catch functions
source "$ZDOTDIR"/completions/_plainplay
compdef _plainplay plainplay play
compdef _playlist_files splay pplay
compdef _binary_completion which-cat launch vic
compdef _editor e
