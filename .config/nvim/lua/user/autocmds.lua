-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = vim.api.nvim_create_augroup('YankHighlight', {clear = true}),
    pattern = '*'
})

-- automatically compile/run commands when I edit particular [config] files
local user_autocompile = vim.api.nvim_create_augroup('UserAutocompile',
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
vim.api.nvim_create_autocmd('TermOpen', {
    command = 'startinsert',
    group = vim.api.nvim_create_augroup('TerminalInsert', {clear = true}),
    pattern = '*'
})

-- disable LLM-generation for .env files
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
    group = vim.api.nvim_create_augroup("LlmGroup", {clear = true}),
    pattern = {".env", ".env.*"},
    callback = function(_) vim.b['codeium_enabled'] = false end
})

-- use the loclist for vim.diagnostics
vim.api.nvim_create_autocmd({'BufWrite', 'BufEnter', 'InsertLeave'}, {
    group = vim.api.nvim_create_augroup('SetDiagnostic', {clear = true}),
    pattern = '*',
    callback = function()
        vim.diagnostic.setloclist({
            open = false,
            severity = vim.diagnostic.severity.HINT
        })
    end
})
