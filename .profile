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
