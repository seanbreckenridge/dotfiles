local wk = require('which-key')
wk.register({
    ["H"] = {
        name = 'hex colors',
        a = {'<cmd>ColorizerAttachToBuffer<CR>', 'attach'},
        e = {'<cmd>ColorizerAttachToBuffer<CR>', 'enable'},
        d = {'<cmd>ColorizerDetachFromBuffer<CR>', 'disable'},
        H = {'<cmd>CccPick<CR>', 'pick color'}
    }
}, {prefix = '<leader>'})

return {
    {
        'norcalli/nvim-colorizer.lua',
        cmd = {'ColorizerAttachToBuffer', 'ColorizerDetachFromBuffer'},
        keys = '<leader>H',
        config = function()
            -- https://github.com/norcalli/nvim-colorizer.lua
            -- colors hex codes/html colors etc #000000
            require('colorizer').setup({
                '*', -- Highlight all files, but customize some others.
                css = {rgb_fn = true}, -- Enable parsing rgb(...) functions in css.
                html = {names = false} -- Disable parsing "names" like Blue or Gray
            })
        end
    }, {
        "uga-rosa/ccc.nvim",
        keys = '<leader>H',
        cmd = 'CccPick',
        opts = {highlighter = {auto_enable = false, lsp = false}}
    }
}

