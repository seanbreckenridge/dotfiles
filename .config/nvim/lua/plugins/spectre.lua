local wk = require('which-key')

wk.register({S = {function() require('spectre').open() end, "spectre"}},
            {mode = "n"})

return {
    'nvim-pack/nvim-spectre',
    event = "InsertEnter",
    keys = "S",
    cmd = "Spectre",
    dependencies = {'nvim-lua/plenary.nvim'},
    opts = {}
}
