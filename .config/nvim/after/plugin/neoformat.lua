vim.g.neoformat_enabled_python = {'black'}
vim.g.neoformat_enabled_html = {'prettier'}
vim.g.neoformat_enabled_javascript = {'prettier'}
vim.g.neoformat_enabled_typescript = {'prettier'}
vim.g.neoformat_enabled_json = {'prettier'}

local wk = require('which-key')

wk.register({t = {':Neoformat<CR>', 'format'}}, {prefix = '<leader>'})
