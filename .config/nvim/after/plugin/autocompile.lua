-- automatically compile/run commands when I edit particular [config] files
vim.cmd [[
  augroup seanbreckenridge_autocompile
    autocmd!
    autocmd BufWritePost ~/.config/shortcuts.toml !reshortcuts
    autocmd BufWritePost ~/.config/i3/config.* !i3-jinja
    autocmd BufWritePost ~/.config/i3blocks/config !rm -f $(evry location -i3blocks-cache)
  augroup end
]]

