# Set PATH in ~/.profile so that
# rofi/other utilities have access to it
# this is sourced at the top of $ZDOTDIR/.zshrc

PATH="\
${HOME}/.local/bin:\
${HOME}/.local/npm-packages/bin:\
${HOME}/.local/scripts/system:\
${HOME}/.local/scripts/bin:\
${HOME}/.local/shortcuts:\
${HOME}/.go/bin:\
${HOME}/.cabal/bin:\
${HOME}/.emacs.d/bin:\
${PATH}"
export PATH

