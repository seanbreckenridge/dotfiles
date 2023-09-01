return {
    'sbdchd/neoformat',
    event = "VeryLazy",
    keys = {"<leader>t"},
    config = function()

        local wk = require("which-key")

        -- seems that vim.lsp.buf.format() that requires a language server to have an opinion on formatting
        -- which is not always the case
        wk.register({':Neoformat<CR>', 'format'}, {prefix = '<leader>t'})
    end
}
