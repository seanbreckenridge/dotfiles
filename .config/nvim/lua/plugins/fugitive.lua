return {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")

        wk.register({
            g = {
                name = "git",
                g = {'<cmd>:Git<CR>:wincmd _<CR>', 'console'},
                p = {'<cmd>:Git push<CR>', 'push'},
                l = {'<cmd>:Git pull<CR>', 'pull'},
                o = {'<cmd>:Git log<CR>', 'log'},
                O = {'<cmd>:Git open<CR>', 'open in browser'}, -- using https://github.com/paulirish/git-open
                c = {'<cmd>:Git commit<CR>:wincmd _<CR>', 'commit'},
                d = {'<cmd>:Git diff<CR>:wincmd _<CR>', 'diff'},
                s = {'<cmd>:Git diff --staged<CR>:wincmd _<CR>', 'diff staged'},
                h = {'<cmd>:Git diff HEAD~1 HEAD<CR>:wincmd _<CR>', 'diff head'},
                u = {'<cmd>:Git add -u<CR>', 'add update'},
                a = {'<cmd>:Git add --all<CR>', 'add all'},
                P = {'<cmd>:Git add --all --patch<CR>', 'add patch'},
                t = {'<cmd>:Git status<CR>', 'status'},
                r = {'<cmd>:Git reset<CR>', 'reset'},
                b = {
                    function()
                        require("telescope.builtin").git_branches()
                    end, 'telescope branch'
                },
                B = {'<cmd>:Git blame<CR>', 'blame'}
            }
        }, {prefix = "<leader>"})
    end
}
