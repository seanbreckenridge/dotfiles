return {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    keys = {"<leader>g"},
    config = function()
        local wk = require("which-key")

        wk.register({
            g = {
                name = "git",
                g = {'<cmd>:Git<CR>:wincmd _<CR>', 'console'},
                s = {'<cmd>:Git<CR>:wincmd _<CR>', 'status'},
                p = {'<cmd>:Git push<CR>', 'push'},
                l = {'<cmd>:Git pull<CR>', 'pull'},
                o = {'<cmd>:Git log<CR>', 'log'},
                c = {'<cmd>:Git commit<CR>:wincmd _<CR>', 'commit'},
                d = {'<cmd>:Git diff<CR>:wincmd _<CR>', 'diff'},
                S = {'<cmd>:Git diff --staged<CR>:wincmd _<CR>', 'diff staged'},
                h = {'<cmd>:Git diff HEAD~1 HEAD<CR>:wincmd _<CR>', 'diff head'},
                u = {'<cmd>:Git add -u<CR>', 'add update'},
                a = {'<cmd>:Git add --all<CR>', 'add all'},
                P = {'<cmd>:Git add --all --patch<CR>', 'add patch'},
                t = {'<cmd>:Git status<CR>', 'status'},
                r = {'<cmd>:Git reset<CR>', 'reset'},
                b = {"<cmd>:Telescope git_branches<CR>", 'telescope branch'}
            }
        }, {prefix = "<leader>"})
    end
}
