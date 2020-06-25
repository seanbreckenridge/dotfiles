# allow menu select w/ highlight
zmodload zsh/complist  # http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
zstyle ':completion:*' menu select  #  http://zsh.sourceforge.net/Guide/zshguide06.html
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # Auto complete with case insenstivity
setopt globdots # allow autocompletion to target hidden files
setopt glob_complete  # wildcard completion, e.g. *.png
setopt completealiases # expand aliases before completing
setopt autocd  # automatically cd into directories

# from gotbletu
# https://github.com/gotbletu/dotfiles_v2/blob/master/normal_user/zshrc/.zshrc
# better killall completion
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'
# when new programs is installed, auto update autocomplete without reloading shell
zstyle ':completion:*' rehash true
# Don't complete stuff already on the line
zstyle ':completion::*:(rm|nvim|e|ls):*' ignore-line true
