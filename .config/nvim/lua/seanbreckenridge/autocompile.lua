-- automatically compile/run commands when I edit particular [config] files
local autocompile_group = vim.api.nvim_create_augroup("autocompile")

local ft_grp = vim.api.nvim_create_augroup("filetype_cmds", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
    group = ft_grp,
    pattern = {"*.job", "*.job.disabled"},
    callback = function(_) vim.cmd("set filetype=bash") end
})

vim.cmd [[
  augroup seanbreckenridge_autocompile
    autocmd!
    autocmd BufWritePost ~/.config/shortcuts.toml !reshortcuts
    autocmd BufWritePost ~/.config/i3/config.* !i3-jinja
    autocmd BufWritePost ~/.config/i3blocks/config !rm -f $(evry location -i3blocks-cache)
  augroup end
]]

