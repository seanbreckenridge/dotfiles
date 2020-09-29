# under certain (interactive, basic) conditions, upgrade a command
# to a fancy version

# if I type python with out any arguments, launch ipython instead
python() { python3 "$@" }
python3() {
  if (( $# == 0 )); then
    echo -e "$(tput setaf 2)Launching ipython instead...$(tput sgr0)"
    ipython
  else
    /usr/bin/python3 "$@"
  fi
}

# if I type cat with only one argument, which is a file that exists
# and this is printing to STDOUT (not a pipe/file), use bat instead
cat() {
  if [[ -t 1 ]] && (($# == 1)) && [[ -r "$1" ]]; then
    # https://github.com/sharkdp/bat
    bat --pager=never --theme=Dracula "$1"
  else
    /usr/bin/cat "$@"
  fi
}

