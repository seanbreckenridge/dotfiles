-- git related bindings
-- fugitive (git) using which-key.nvim
local wk = require('which-key')
local tb = require('telescope.builtin')

wk.register({
    g = {
        name = "git",
        g = {'<cmd>:Git<CR>:wincmd _<CR>', 'console'},
        s = {'<cmd>:Git<CR>:wincmd _<CR>', 'console'},
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
        b = {tb.git_branches, 'telescope branch'}
    }
}, {prefix = "<leader>"})

-- for picking which files to merge from while resolving merge conflicts
-- middle is what the final merged file is
-- gj to pick hunk from the right (under right index)
-- gf to pick hunk form the left (under left index)
wk.register({
    name = "git merge",
    j = {':diffget //3<CR>', 'diffget //3'},
    f = {':diffget //2<CR>', 'diffget //2'}
}, {prefix = "<leader>i"})
