local wk = require('which-key')

-- disable arrow keys
vim.api.nvim_set_keymap('', '<Down>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('', '<Left>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('', '<Right>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('', '<Up>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Down>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Left>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Right>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Up>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Down>', '<Nop>', {noremap = true})
-- disable capital Q (:ex mode)
vim.api.nvim_set_keymap('n', 'Q', '<Nop>', {noremap = true})

-- copy visual selection to clipboard
-- vim.api.nvim_set_keymap('v', '<leader>c', '"+y', {noremap = true})
-- vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<leader>y', 'V"+y', {noremap = true})

-- move items while text is highlighted
vim.api.nvim_set_keymap('v', 'J', ':move \'>+1<CR>gv=gv', {noremap = true})
vim.api.nvim_set_keymap('v', 'K', ':move \'<-2<CR>gv=gv', {noremap = true})

-- misc
wk.register({
    -- reminder, can use 'P' in netrw to open in right tab
    e = {':wincmd v<bar> :Explore <bar> :vertical resize 30<CR>', 'netrw'},
    s = {':set spell!<CR>', 'toggle spell'},
    ["S"] = {
        ':so ~/.config/nvim/init.lua<CR>:lua require("seanbreckenridge.colors").setup_theme()<CR>',
        'reload config'
    },
    x = {':!chmod +x %<CR>', 'make executable'}
}, {prefix = '<space>'})

-- nicer bindings for moving between windows
-- window/buffers

wk.register({b = {'<C-^><CR>', 'swap buffers'}, w = {'<C-W>', 'window'}},
            {prefix = '<leader>'})

-- separating these into separate register calls let me use the name
wk.register({
    W = {
        name = "window/buffers",
        ["="] = {':vertical resize +5<CR>', 'vertical increase window size'},
        ["-"] = {':vertical resize -5<CR>', 'vertical decrease window size'},
        ["s"] = {'<C-W>s', 'horizontal split'},
        ["v"] = {'<C-W>v', 'vertical split'}
    }
}, {prefix = '<leader>'})

-- seems that vim.lsp.buf.format() that requires a language server to have an opinion on formatting
-- which is not always the case
wk.register({':Neoformat<CR>', 'format'}, {prefix = '<leader>t'})

wk.register({u = {':UndotreeToggle<CR>', 'undo tree'}}, {prefix = '<leader>'})

-- function to toggle quickfix lists
vim.api.nvim_set_keymap('n', '<C-q>', ':lua ToggleQFList(1)<CR>',
                        {noremap = true})

-- quickfix list mappings
wk.register({
    q = {
        name = 'quickfix',
        j = {'qj', 'next'},
        k = {'qk', 'prev'},
        q = {function() ToggleQFList(1) end, 'toggle'}
    }
}, {prefix = '<leader>'})

-- function to toggle loc list
vim.api.nvim_set_keymap('n', '<C-l>', ':lua ToggleQFList(0)<CR>',
                        {noremap = true})

-- loc list mappings
wk.register({
    l = {
        name = 'loc list',
        j = {'lj', 'next'},
        k = {'lk', 'prev'},
        l = {function() ToggleQFList(0) end, 'toggle'}
    }
}, {prefix = '<leader>'})

vim.g.seanbreckenridge_qf_l = 0
vim.g.seanbreckenridge_qf_g = 0

function ToggleQFList(global)
    if global == 1 then
        if vim.g.seanbreckenridge_qf_g == 1 then
            vim.g.seanbreckenridge_qf_g = 0
            vim.cmd('cclose')
        else
            vim.g.seanbreckenridge_qf_g = 1
            vim.cmd('copen')
        end
    else
        if vim.g.seanbreckenridge_qf_l == 1 then
            vim.g.seanbreckenridge_qf_l = 0
            vim.cmd('lclose')
        else
            vim.g.seanbreckenridge_qf_l = 1
            vim.cmd('lopen')
        end
    end
end

-- plugins
wk.register({u = {'<cmd>UndotreeToggle<cr>', 'undotree'}}, {prefix = '<leader>'})

-- https://github.com/norcalli/nvim-colorizer.lua
-- colors hex codes/html colors etc #000000
wk.register({
    ["C"] = {
        name = 'hex colors',
        a = {'<cmd>ColorizerAttachToBuffer<CR>', 'attach'},
        e = {'<cmd>ColorizerAttachToBuffer<CR>', 'enable'},
        d = {'<cmd>ColorizerDetachFromBuffer<CR>', 'disable'}
    }
}, {prefix = '<leader>'})

-- git (fugitive)
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
        r = {'<cmd>:Git reset<CR>', 'reset'}
        -- b = {tb.git_branches, 'telescope branch'}
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

-- lsp bindings

function ShowDocumentation()
    if vim.tbl_contains({'vim', 'help'}, vim.bo.filetype) then
        vim.cmd('h ' .. vim.fn.expand('<cword>'))
    else
        vim.lsp.buf.hover()
    end
end

-- lsp commands with leader prefix
wk.register({
    T = {vim.lsp.buf.code_action, "lsp code action"},
    r = {vim.lsp.buf.rename, "lsp rename"}
}, {prefix = "<leader>"})

-- lsp commands in normal mode
wk.register({
    [']w'] = {vim.diagnostic.goto_next, "next diagnostic"},
    ['[w'] = {vim.diagnostic.goto_prev, "prev diagnostic"},
    gd = {vim.lsp.buf.definition, "goto definition"},
    gr = {vim.lsp.buf.references, "goto references"},
    K = {ShowDocumentation, "show documentation"}
})

-- use loclist for lsp diagnostics
vim.cmd([[
augroup seanbreckenridge_lsp
  autocmd!
  autocmd! BufWrite,BufEnter,InsertLeave * lua vim.diagnostic.setloclist({open=false, severity = {min=vim.diagnostic.severity.HINT}})
augroup END
]])

-- copilot
vim.cmd([[
" copilot
" remove tab mapping -- map to alt+c
" to swap between choices, use alt+] and alt+[
imap <silent><script><expr> <M-c> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

let g:copilot_filetypes = {'*': v:true ,
  \ 'help': v:false,
  \ }
  ]])
