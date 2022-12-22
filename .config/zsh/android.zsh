# android-specific setup
# this is mostly handling anacron-like
# tasks that run periodically

# jobs in bgproc shouldnt wait before timeout
# otherwise when terminal opens its waiting ~30 seconds
# before the shell finishes opening when I don't have internet
export WFI_TIMEOUT=0

# run bgproc jobs
# https://github.com/seanbreckenridge/bgproc
evry 1 hour -run_android_jobs && bgproc_on_machine -on

# sync HPI config from syncthing dir to ~/.config so I have access to synced secrets
evry 1 hour -sync_hpi_config && sync_hpi_config

# reset any periodic syncs and re-run bgproc jobs
syncfiles() {
	for tag in \
		twistytimer \
		backup_images; do
		rm -f "$(evry location -"$tag")"
	done
	sync_hpi_config
	bgproc_on_machine -onq
}
alias sf=syncfiles

uu() {
	syncfiles
	repos-pull-all
}

# for building rust/ffi python packages
export CARGO_BUILD_TARGET=aarch64-linux-android

# for building some python libs with C-extensions
export SODIUM_INSTALL=system

alias dcim='R ~/storage/dcim/Camera'
alias d=dcim
alias sd='sf; dcim'
