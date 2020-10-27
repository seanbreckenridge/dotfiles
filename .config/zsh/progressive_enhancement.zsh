# under certain (interactive, basic) conditions, upgrade a command
# to a fancy version

# if I type python with out any arguments, launch ipython instead
python() {
	python3 "$@"
}
python3() {
	if (($# == 0)); then
		echo -e "$(tput setaf 2)Launching ipython instead...$(tput sgr0)"
		ipython
	else
		command python3 "$@"
	fi
}

# if I type cat with only one argument, which is a file that exists
# and this is printing to STDOUT (not a pipe/file), use bat instead
cat() {
	if [[ -t 1 ]] && (($# == 1)) && [[ -r "$1" ]]; then
		# https://github.com/sharkdp/bat
		bat --pager=never "$1"
	else
		command cat "$@"
	fi
}

# If I run 'ps -ef' with nothing else, without piping it into anything else, use procs instead
ps() {
	if [[ -t 1 ]] && [[ "$1" == "-ef" ]] && (($# == 1)); then
		procs --pager=disable
		echo "Instead of 'ps -ef | grep something', just use 'procs something'" 1>&2
	else
		command ps "$@"
	fi
}
