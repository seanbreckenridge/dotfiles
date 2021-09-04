#!/usr/bin/env zsh
# android-specific setup
# this is mostly handling anacron-like
# tasks that run periodically

# run bgproc jobs
# https://github.com/seanbreckenridge/dotfiles/tree/master/.local/scripts/supervisor
# https://github.com/seanbreckenridge/bgproc
evry 6 hours -run_android_jobs && "${HOME}/.local/scripts/supervisor/run_jobs" -o

gpslogger_backup() {
	su -c 'rsync -Pavh "/data/data/com.termux/files/home/shared/Android/data/com.mendhak.gpslogger/files/"* "/data/data/com.termux/files/home/storage/shared/data/gpslogger"'
}

# run this in the interactive shell since that works with su
# otherwise calling it as a script behind bgproc fails
evry 1 day -gpslogger && gpslogger_backup
