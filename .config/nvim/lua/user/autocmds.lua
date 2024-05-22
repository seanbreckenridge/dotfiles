-- automatically compile/run commands when I edit particular [config] files
vim.cmd [[
  augroup user_autocompile
    autocmd!
    autocmd BufWritePost ~/.config/shortcuts.toml !reshortcuts
    autocmd BufWritePost ~/.config/i3/config.* !i3-jinja
    autocmd BufWritePost ~/.config/i3blocks/config !rm -f $(evry location -i3blocks-cache)
  augroup end
]]

vim.cmd [[
    augroup terminal_insert
      autocmd TermOpen * startinsert
    augroup end
]]

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight',
                                                    {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*'
})

-- disable copilot for .env files
local copilot_grp = vim.api.nvim_create_augroup("copilot", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
    group = copilot_grp,
    pattern = {".env", ".env.*"},
    callback = function(_) vim.b['copilot_enabled'] = 0 end
})

-- set filetype for todo.txt files
vim.filetype.add({
    filename = {['todo.txt'] = 'todotxt', ['done.txt'] = 'todotxt'}
})

-- use loclist for lsp diagnostics
vim.cmd([[
augroup user_diagnostics
  autocmd!
  autocmd! BufWrite,BufEnter,InsertLeave * lua vim.diagnostic.setloclist({open=false, severity = {min=vim.diagnostic.severity.HINT}})
augroup END
]])
