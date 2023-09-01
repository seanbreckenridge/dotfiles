return {
    'norcalli/nvim-colorizer.lua',
    event = "VeryLazy",
    config = function()
        -- https://github.com/norcalli/nvim-colorizer.lua
        -- colors hex codes/html colors etc #000000
        local wk = require('which-key')
        wk.register({
            ["C"] = {
                name = 'hex colors',
                a = {'<cmd>ColorizerAttachToBuffer<CR>', 'attach'},
                e = {'<cmd>ColorizerAttachToBuffer<CR>', 'enable'},
                d = {'<cmd>ColorizerDetachFromBuffer<CR>', 'disable'}
            }
        }, {prefix = '<leader>'})
    end
}
