# Additional/non-zsh alias/path/function/config

# Path manipulations for user scripts and package manager (pip, npm, cargo) bin dirs
# User compiled binaries are copied to /usr/local/bin
PATH="\
${HOME}/bin:\
${HOME}/.local/bin:\
${NPM_PACKAGES}/bin:\
${HOME}/.configbin:\
${PATH}"
export PATH

# inherit from /etc/manpath and add npm man pages
unset MANPATH
MANPATH="\
${NPM_PACKAGES}/share/man:\
$(manpath)"
export MANPATH

# antigen configuration
source /usr/share/zsh/share/antigen.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle command-not-found
antigen theme denysdovhan/spaceship-prompt
antigen apply

# zsh theme
ZSH_THEME="spaceship"

# some completion features from: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
autoload -Uz compinit  # zsh tab completion
zstyle ':completion:*' menu select  #  http://zsh.sourceforge.net/Guide/zshguide06.html
zmodload zsh/complist  # http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fcomplist-Module
setopt globdots

# load user defined functions
for func in $(command ls -1 "${ZDOTDIR}/functions/"); do
  autoload -Uz $func
done

# Aliases

# Standard
alias reboot="sudo systemctl reboot"
alias poweroff="sudo systemctl poweroff"
alias halt="sudo systemctl halt"

# Non-standard
alias dotfiles='yadm gitconfig --get remote.origin.url | python3 -c "from giturlparse import parse; from webbrowser import open_new_tab; open_new_tab(parse(input()).urls[\"https\"])"'
alias printer_server='sudo cat /etc/cups/cupsd.conf | grep -i "Listen localhost" | cut -d":" -f 2 | xargs -I {} $BROWSER "localhost:{}"'

# Shorthands
[[ -f ~/.zsh/shorthands ]] && source ~/.zsh/shorthands

# Personal Aliases
[[ -f ~/.zsh/zsh_aliases ]] && source ~/.zsh/zsh_aliases

# app specific init
eval $(thefuck --alias)
kitty +complete setup zsh | source /dev/stdin
# Change npm install dir from /usr/local/bin (which requires sudo)
# ~/.npmrc should have the contents:  `prefix=${HOME}/.npm-packages`
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="${NPM_PACKAGES}/lib/node_modules:${NODE_PATH}"
# powerline
powerline-daemon -q
source /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh
