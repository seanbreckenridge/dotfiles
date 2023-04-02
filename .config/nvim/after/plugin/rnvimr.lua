-- ranger in a vim buffer
vim.api.nvim_set_keymap('n', '<A-r>', ':RnvimrToggle<CR>', {silent = true})
vim.api.nvim_set_keymap('t', '<A-i>', '<C-\\><C-n>:RnvimrResize<CR>',
                        {silent = true})
vim.api.nvim_set_keymap('t', '<A-o>', '<C-\\><C-n>:RnvimrToggle<CR>',
                        {silent = true})

-- Map Rnvimr action
-- A-r (same binding that opens rnvim
-- opens the file in the parent nvim instance)
--
-- can use enter as usual to open non-text files in ranger
vim.g.rnvimr_action = {
    ['<A-r>'] = 'NvimEdit split',
    ['<C-x>'] = 'NvimEdit split',
    ['<C-v>'] = 'NvimEdit vsplit',
    gw = 'JumpNvimCwd',
    yw = 'EmitRangerCwd'
}
