#!/usr/bin/zsh
# on some machines (WSL/termux),
# I can't sync to the ~/.config directory easily
# so this is a workaround, which syncs to somewhere
# else syncthing has access to and periodically
# rsyncs to the ~/.config directory
# this is called from android.zsh/windows.zsh files

sync_hpi_config() {
	local hpi_synced_dir
	echo 'Syncing HPI config...'
	for base in "$WHOME" "$HOME/storage/shared"; do
		hpi_synced_dir="${base}/hpi_config"
		[[ -d "$hpi_synced_dir" ]] || continue
		rsync -Pavh "$hpi_synced_dir/my" ~/.config/my/
		chmod -x ~/.config/my/my/config/*.py
		return 0
	done
	printf 'Could not find synced HPI config\n'
}

# update data sources for commonly updated data (music, tv shows, listens)
# and then run an index for https://github.com/seanbreckenridge/my_feed
feed_update_partials() {
	for tag in \
		backup_albums \
		backup_trakt_partial \
		my-feed-index \
		partial_listenbrainz_scrobbles; do
		rm -vf "$(evry location -"$tag")"
	done
	~/.local/scripts/supervisor/run_jobs -o
	housekeeping
}
