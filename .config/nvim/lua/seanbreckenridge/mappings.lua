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

-- sync clipboard with system clipboard
vim.opt.clipboard = 'unnamedplus'

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
