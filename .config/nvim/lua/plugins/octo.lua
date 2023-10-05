local wk = require("which-key")

wk.register({
    o = {
        name = "octo",
        i = {":Octo issue list<CR>", "list issues"},
        I = {":Octo issue list --mine<CR>", "list my issues"},
        c = {":Octo issue create<CR>", "create issue"},
        p = {":Octo pr list<CR>", "list pull requests"},
        P = {":Octo pr list --mine<CR>", "list my pull requests"}
    }
}, {prefix = "<leader>"})

return {
    "pwntester/octo.nvim",
    keys = {"<leader>o"},
    cmd = {"Octo"},
    dependencies = {
        'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim',
        'nvim-tree/nvim-web-devicons'
    },
    config = function() require("octo").setup() end
}
