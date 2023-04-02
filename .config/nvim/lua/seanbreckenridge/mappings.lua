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

-- copy visual selection to clipboard
vim.api.nvim_set_keymap('v', '<leader>c', '"+y', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>y', 'V"+y', {noremap = true})

-- open netrw like a sidebar file manager
vim.api.nvim_set_keymap('n', '<leader>e',
                        ':wincmd v<bar> :Explore <bar> :vertical resize 30<CR>',
                        {noremap = true})
-- open netrw full screen
vim.api.nvim_set_keymap('n', '<leader>E', ':Explore<CR>', {noremap = true})
-- resource config
vim.api.nvim_set_keymap('n', '<Leader><CR>',
                        ':so ~/.config/nvim/init.lua<CR>:lua require("seanbreckenridge.colors").setup_theme()<CR>',
                        {noremap = true})

-- nicer bindings for moving between windows
-- window/buffers

-- swap between buffers
vim.api.nvim_set_keymap('n', '<leader>b', '<C-^><CR>', {noremap = true})

-- nicer binding for window management
vim.api.nvim_set_keymap('n', '<leader>w', '<C-W>', {noremap = true})
-- can use <leader>w+ and <leader>w- to increase
-- vertical resizing
vim.api.nvim_set_keymap('n', '<leader>=', ':vertical resize +5<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>-', ':vertical resize -5<CR>',
                        {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>+', ':wincmd +<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>_', ':wincmd -<CR>', {noremap = true})

-- quickfix lists
vim.api.nvim_set_keymap('n', '<leader>gj', ':cnext<CR>zz', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gk', ':cprev<CR>zz', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>j', ':lnext<CR>zz', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>k', ':lprev<CR>zz', {noremap = true})

-- function to toggle quickfix lists
vim.api.nvim_set_keymap('n', '<C-q>', ':lua ToggleQFList(1)<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>q', ':lua ToggleQFList(0)<CR>',
                        {noremap = true})

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
