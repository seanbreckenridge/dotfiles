# Additional/non-zsh alias/path/function/config

### npm configuration

# Change npm install dir from /usr/local/bin (which requires sudo)
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="${NPM_PACKAGES}/lib/node_modules:${NODE_PATH}"

###
# ~/.npmrc should have the contents:  `prefix=${HOME}/.npm-packages`
###

# Path manipulations for user scripts and package manager (pip, npm, cargo) bin dirs
# User compiled binaries are copied to /usr/local/bin
PATH="\
${HOME}/bin:\
${HOME}/.local/bin:\
${NPM_PACKAGES}/bin:\
${PATH}"
export PATH

# inherit from /etc/manpath and add npm man pages
unset MANPATH
MANPATH="\
${NPM_PACKAGES}/share/man:\
$(manpath)"
export MANPATH

# load functions
for func in $(command ls -1 "${ZDOTDIR}/functions/"); do
  autoload -Uz $func
done

# Aliases
alias ll='ls -l'
alias la='ll -a'
