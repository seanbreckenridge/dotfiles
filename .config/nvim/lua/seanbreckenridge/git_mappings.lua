-- git related bindings
-- fugitive (git) using which-key.nvim
local wk = require('which-key')
wk.register({
    g = {
        name = "git",
        g = {':Git<CR>:wincmd _<CR>', 'console'},
        p = {':Git push<CR>', 'push'},
        l = {':Git pull<CR>', 'pull'},
        o = {':Git log<CR>', 'log'},
        c = {':Git commit<CR>:wincmd _<CR>', 'commit'},
        d = {':Git diff<CR>:wincmd _<CR>', 'diff'},
        S = {':Git diff --staged<CR>:wincmd _<CR>', 'diff staged'},
        h = {':Git diff HEAD~1 HEAD<CR>:wincmd _<CR>', 'diff head'},
        u = {':Git add -u<CR>', 'add update'},
        A = {':Git add --all<CR>', 'add all'},
        P = {':Git add --all --patch<CR>', 'add patch'},
        t = {':Git status<CR>', 'status'},
        r = {':Git reset<CR>', 'reset'}
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
