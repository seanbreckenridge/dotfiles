#!/usr/bin/env zsh
# android-specific setup

# run bgproc jobs
# https://github.com/seanbreckenridge/dotfiles/tree/master/.local/scripts/supervisor
# https://github.com/seanbreckenridge/bgproc
evry 6 hours -run_android_jobs && "${HOME}/.local/scripts/supervisor/run_jobs" -o
