# Set PATH in ~/.profile so that
# rofi/other utilities have access to it
# this is sourced at the top of $ZDOTDIR/.zshrc

PATH="\
${HOME}/.local/bin:\
${HOME}/.npm-packages/bin:\
${HOME}/.scripts/system:\
${HOME}/.scripts/bin:\
${HOME}/.local/shortcuts:\
${PATH}"
export PATH

