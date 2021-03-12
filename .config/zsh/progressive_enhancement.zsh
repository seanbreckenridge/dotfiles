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

# If I run 'ps -ef' with nothing else, without piping it into anything else, use procs instead
ps() {
	if [[ -t 1 ]] && [[ "$1" == "-ef" ]] && (($# == 1)); then
		procs --pager=disable
		echo "Instead of 'ps -ef | grep something', just use 'procs something'" 1>&2
	else
		command ps "$@"
	fi
}

# https://github.com/odeke-em/drive
# if I run drive outside my google drive
# move to ~/GoogleDrive/
drive() {
	local defaultdrive="${HOME}/GoogleDrive"

	# early exit if drive doesnt exist where I expect
	[[ ! -r "${defaultdrive}" ]] && command drive "$@"

	# if not trying to create another google drive instance
	if [[ "$1" != 'init' ]]; then
		if ! grep -q "${defaultdrive}" <<<"${PWD}"; then
			cd "${defaultdrive}" || {
				printf "Couldnt change directory to %s\n" "${defaultdrive}"
			}
		fi
	fi
	command drive "$@"
}

# https://github.com/charmbracelet/glow
glow() {
	# if passed with no arguments
	# and theres only one .md file in this
	# directory, automatically use it
	if (($# == 0)); then
		local -a MD_FILES
		MD_FILES=()
		while IFS= read -r file; do
			MD_FILES+=("$file")
		done < <(find . -maxdepth 1 -name '*.md')
		if [[ "${#MD_FILES[@]}" == "1" ]]; then
			command glow "${MD_FILES[*]}"
		else
			command glow "$@"
		fi
	else
		command glow "$@"
	fi
}
