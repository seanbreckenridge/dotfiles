local wk = require('which-key')
wk.register({["H"] = {name = 'hex colors'}}, {prefix = '<leader>'})

return {
    {
        'norcalli/nvim-colorizer.lua',
        cmd = {'ColorizerAttachToBuffer', 'ColorizerDetachFromBuffer'},
        keys = {
            {'<leader>Ha', '<cmd>ColorizerAttachToBuffer<CR>', desc = 'attach'},
            {'<leader>He', '<cmd>ColorizerAttachToBuffer<CR>', desc = 'enable'},
            {
                '<leader>Hd',
                '<cmd>ColorizerDetachFromBuffer<CR>',
                desc = 'disable'
            }
        },
        -- https://github.com/norcalli/nvim-colorizer.lua
        -- colors hex codes/html colors etc #000000
        opts = {
            '*', -- Highlight all files, but customize some others.
            css = {rgb_fn = true}, -- Enable parsing rgb(...) functions in css.
            html = {names = false} -- Disable parsing "names" like Blue or Gray
        }
    }, {
        "uga-rosa/ccc.nvim",
        keys = {{'<leader>HH', ':<cmd>CccPick<CR>', desc = 'pick color'}},
        cmd = 'CccPick',
        opts = {highlighter = {auto_enable = false, lsp = false}}
    }
}

