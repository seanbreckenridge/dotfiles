-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight',
                                                    {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*'
})

-- automatically compile/run commands when I edit particular [config] files
local user_autocompile = vim.api.nvim_create_augroup('user_autocompile',
                                                     {clear = true})
vim.api.nvim_create_autocmd('BufWritePost', {
    command = '!reshortcuts',
    group = user_autocompile,
    pattern = {'.config/shortcuts.toml', 'shortcuts.toml'}
})

vim.api.nvim_create_autocmd('BufWritePost', {
    command = '!i3-jinja',
    group = user_autocompile,
    pattern = {'.config/i3/config.j2', 'i3/config.j2'}
})

vim.api.nvim_create_autocmd('BufWritePost', {
    command = '!rm -f $(evry location -i3blocks-cache)',
    group = user_autocompile,
    pattern = {'.config/i3blocks/config.*', 'i3blocks/config.*'}
})

-- enter insert mode when I open a terminal
local terminal_insert = vim.api.nvim_create_augroup('terminal_insert',
                                                    {clear = true})
vim.api.nvim_create_autocmd('TermOpen', {
    command = 'startinsert',
    group = terminal_insert,
    pattern = '*'
})

-- disable copilot for .env files
local copilot_grp = vim.api.nvim_create_augroup("copilot", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
    group = copilot_grp,
    pattern = {".env", ".env.*"},
    callback = function(_) vim.b['copilot_enabled'] = 0 end
})

-- use the loclist for vim.diagnostics
local user_diagnostic = vim.api.nvim_create_augroup('user_diagnostic',
                                                    {clear = true})

vim.api.nvim_create_autocmd({'BufWrite', 'BufEnter', 'InsertLeave'}, {
    group = user_diagnostic,
    pattern = '*',
    callback = function()
        vim.diagnostic.setloclist({
            open = false,
            severity = vim.diagnostic.severity.HINT
        })
    end
})
