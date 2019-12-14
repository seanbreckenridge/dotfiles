# Set PATH in ~/.profile so that
# rofi/other utilities have access to it
# this is sourced at the top of $ZDOTDIR/.zshrc

PATH="\
${HOME}/bin:\
${HOME}/.local/bin:\
${HOME}/.npm-packages/bin:\
${HOME}/.scripts:\
${HOME}/.shortcuts:\
${PATH}"
export PATH

