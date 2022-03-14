" automatically compile/run commands when I edit particular [config] files

" create shortcuts, whenever I edit the config file
" https://github.com/seanbreckenridge/shortcuts
autocmd BufWritePost ~/.config/shortcuts.toml !reshortcuts
" run i3-jinja to re-create i3 conf file when editing the jinja or yaml bindings
" see https://github.com/seanbreckenridge/dotfiles/tree/master/.config/i3
autocmd BufWritePost ~/.config/i3/config.* !i3-jinja
" remove evry cache file when I edit my i3blocks config, so that
" https://sean.fish/d/i3blocks-refresh-mk?dark updates the signal cache
autocmd BufWritePost ~/.config/i3blocks/config !rm -f $(evry location -i3blocks-cache)
