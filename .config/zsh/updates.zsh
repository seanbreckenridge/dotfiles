#!/bin/zsh
# move these into language specific functions, so I'm not updating everything all the time

update_nvim() {
	nvim +PlugUpdate +qall
}

update_npm() {
	if command -v npm | grep -q 'npm-packages'; then
		npm update -g
	else
		echo 'npm path has been mangled (e.g. by nvm/asdf), skipping update...'
	fi
}

update_gem() {
	gem update
} && alias update_ruby='update_gem'

update_pip() {
	python -m pip install --user -U -r "${XDG_CONFIG_HOME}/yadm/package_lists/python3_packages.txt"
}

update_cargo() {
	cargo install-update -a
}

update_golang() {
	cd || return $?
	spkglist "$HOME/.config/yadm/package_lists/go_packages.txt" | awk '{ print $2 "@latest" }' | xargs -I '{}' go install -v "{}"
	cd "$OLDPWD" || return $?
}

update_basher() {
	(cd "$(basher package-path .)" && git pull)
	basher-upgrade-all
}

update_lang_all() {
	update_nvim
	update_npm
	update_gem
	update_pip
	update_cargo
	update_golang
	update_basher
}
