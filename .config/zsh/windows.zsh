#!/usr/bin/env zsh
# run bgproc jobs once every 2 hours
#
# https://github.com/seanbreckenridge/dotfiles/tree/master/.local/scripts/supervisor
# https://github.com/seanbreckenridge/bgproc
evry 2 hours -run_windows_jobs && "${HOME}/.local/scripts/supervisor/run_jobs" -o

evry 1 hour -sync_hpi_config && sync_hpi_config
