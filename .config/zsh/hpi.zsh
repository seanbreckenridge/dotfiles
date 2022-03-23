#!/usr/bin/zsh

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
