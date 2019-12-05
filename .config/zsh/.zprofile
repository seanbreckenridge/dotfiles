# Set PATH in ~/.profile in addition to zsh config files so that
# rofi/system utilities have access to it

PATH="\
${HOME}/bin:\
${HOME}/.local/bin:\
${HOME}/.npm-packages/bin:\
${HOME}/.scripts:\
${PATH}"
export PATH

