return {
    'tpope/vim-fugitive',
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")

        wk.register({
            g = {
                name = "git",
                g = {'<Cmd>Git<CR>:wincmd _<CR>', 'console'},
                p = {'<Cmd>Git push<CR>', 'push'},
                l = {'<Cmd>Git pull<CR>', 'pull'},
                o = {'<Cmd>Git log<CR>', 'log'},
                O = {'<Cmd>Git open<CR>', 'open in browser'}, -- using https://github.com/paulirish/git-open
                c = {'<Cmd>Git commit<CR>:wincmd _<CR>', 'commit'},
                d = {'<Cmd>Git diff<CR>:wincmd _<CR>', 'diff'},
                s = {'<Cmd>Git diff --staged<CR>:wincmd _<CR>', 'diff staged'},
                h = {'<Cmd>Git diff HEAD~1 HEAD<CR>:wincmd _<CR>', 'diff head'},
                u = {'<Cmd>Git add -u<CR>', 'add update'},
                a = {'<Cmd>Git add --all<CR>', 'add all'},
                P = {'<Cmd>Git add --all --patch<CR>', 'add patch'},
                t = {'<Cmd>Git status<CR>', 'status'},
                r = {'<Cmd>Git reset<CR>', 'reset'},
                b = {
                    function()
                        require("telescope.builtin").git_branches()
                    end, 'telescope branch'
                },
                B = {'<Cmd>Git blame<CR>', 'blame'}
            }
        }, {prefix = "<leader>"})
    end
}
