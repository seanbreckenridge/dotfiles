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

man() {
	if [[ -z "$1" ]]; then
		macho
	else
		command man "$@"
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

alias icat='kitty +kitten icat'

# https://github.com/sharkdp/bat
# https://github.com/ogham/exa
# https://sw.kovidgoyal.net/kitty/kittens/icat/
#
# if trying to 'cat' all images -- use kitty to print the image directly in the terminal
# if only one argument and a directory, ls instead
# else, use bat
cat() {
	local all_images=1

	# loop through arguments
	# if its not an image, break -- and use bat instead
	# if I'm in tmux -- kitty cant print images, so fallback
	for arg in "${@}"; do
		[[ -z "$TMUX" && -f "$arg" && "$(file-mime "$1")" =~ '^image/' ]] && continue
		all_images=0
		break
	done

	if [[ -d "$1" ]]; then
		exa "$1"
	elif ((all_images)); then
		icat "$@"
	else
		bat "$@"
	fi
}
