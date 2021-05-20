#!/usr/bin/env zsh
# android-specific setup

# run bgproc jobs once a day when I login
# https://github.com/seanbreckenridge/dotfiles/tree/master/.local/scripts/supervisor
# https://github.com/seanbreckenridge/bgproc
evry 1 day -run_android_jobs && "${HOME}/.local/scripts/supervisor/run_jobs" -o
