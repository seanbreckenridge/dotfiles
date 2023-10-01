# android-specific setup
# this is mostly handling anacron-like
# tasks that run periodically

# jobs in bgproc shouldn't wait before timeout
# otherwise when terminal opens its waiting ~30 seconds
# before the shell finishes opening when I don't have internet
export WFI_TIMEOUT=0

uqf() {
	bgproc_on_machine -nqoF 4
}

# run bgproc jobs
# https://github.com/seanbreckenridge/bgproc
evry 1 hour -run_android_jobs && {
	echo 'running jobs...' >&2
	uqf
}

# sync HPI config from syncthing dir to ~/.config so I have access to synced secrets
evry 1 hour -sync_hpi_config && sync_hpi_config

# reset any periodic syncs and re-run bgproc jobs
syncfiles() {
	for tag in \
		twistytimer \
		aw-window \
		backup_images; do
		rm -f "$(evry location -"$tag")"
	done
	sync_hpi_config
	uqf
}
alias sf=syncfiles

uu() {
	syncfiles
	wait-for-internet --timeout 1 --quiet && {
		yadm pull
		repos-pull-all
	}
}

# for building rust/ffi python packages
export CARGO_BUILD_TARGET=aarch64-linux-android

# for building some python libs with C-extensions
export SODIUM_INSTALL=system

alias dcim='R ~/storage/dcim/Camera'
alias d=dcim
alias sd='sf; dcim'

C() {
	local picked
	# let user pick directory or link that can be cd'd do
	picked="$(find . -mindepth 1 -maxdepth 1 -type d -o -type l | fzf)"
	if [[ -e "$picked" ]]; then
		cd "$picked" || return 1
	else
		echo "no directory picked"
		return 1
	fi
}
