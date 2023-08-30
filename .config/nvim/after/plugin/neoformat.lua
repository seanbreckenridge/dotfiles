vim.g.neoformat_enabled_python = {'black'}
vim.g.neoformat_enabled_html = {'prettier'}
vim.g.neoformat_enabled_javascript = {'prettier'}
vim.g.neoformat_enabled_typescript = {'prettier'}
vim.g.neoformat_enabled_json = {'prettier'}

local wk = require('which-key')

-- TODO: use vim.lsp.buf.format() instead?
-- https://github.com/nvim-lua/kickstart.nvim/blob/1a971cbdcffdc204e073d8142e5491e1f976a3eb/init.lua#L423-L426
wk.register({t = {':Neoformat<CR>', 'format'}}, {prefix = '<leader>'})
