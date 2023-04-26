#!/bin/zsh
# move these into language specific functions, so I'm not updating everything all the time

update_nvim() {
	echo "Updating nvim..."
	nvim +PackerSync
}

update_node() {
	echo "Updating global node packages..."
	yarn global --prefix "${HOME}/.local/" upgrade
}

update_gem() {
	echo "Updating ruby packages..."
	gem update
} && alias update_ruby='update_gem'

update_pip() {
	echo "Updating python packages..."
	python -m pip install --user -U -r "${XDG_CONFIG_HOME}/yadm/package_lists/python3_packages.txt"
}

update_cargo() {
	echo "Updating cargo packages..."
	cargo install-update -a
}

update_golang() {
	echo "Updating golang packages..."
	cd || return $?
	spkglist "$HOME/.config/yadm/package_lists/go_packages.txt" | awk '{ print $2 "@latest" }' | xargs -I '{}' go install -v "{}"
	cd "$OLDPWD" || return $?
}

update_basher() {
	echo "Updating bash scripts..."
	(cd "$(basher package-path .)" && git pull)
	basher-upgrade-all
}

update_lang_all() {
	update_node
	update_gem
	update_pip
	update_cargo
	update_golang
	update_basher
	update_nvim
}
