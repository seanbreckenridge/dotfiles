#!/usr/bin/env zsh
# android-specific setup
# this is mostly handling anacron-like
# tasks that run periodically

# run bgproc jobs
# https://github.com/seanbreckenridge/dotfiles/tree/master/.local/scripts/supervisor
# https://github.com/seanbreckenridge/bgproc
evry 6 hours -run_android_jobs && "${HOME}/.local/scripts/supervisor/run_jobs" -o

# reset any periodic syncs and re-run bgproc jobs
syncfiles() {
	for tag in \
		backup_images; do
		rm -f "$(evry location -"$tag")"
	done
	run-jobs -o
}
alias sf=syncfiles

# for building rust/ffi python packages
export CARGO_BUILD_TARGET=aarch64-linux-android
