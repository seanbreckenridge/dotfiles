vim.g.neoformat_enabled_python = {'black'}
vim.g.neoformat_enabled_html = {'prettier'}
vim.g.neoformat_enabled_javascript = {'prettier'}
vim.g.neoformat_enabled_typescript = {'prettier'}
vim.g.neoformat_enabled_json = {'prettier'}

vim.api.nvim_set_keymap('n', '<leader>t', ':Neoformat<CR>', {noremap = true})
