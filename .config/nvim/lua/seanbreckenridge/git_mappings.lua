-- git related bindings
-- fugitive (git)
vim.api.nvim_set_keymap('n', '<leader>G', ':G<CR>:wincmd _<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ip', ':Git push<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ill', ':Git pull<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ilo', ':Git log<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ic', ':Git commit<CR>:wincmd _<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>idd', ':Git diff<CR>:wincmd _<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ids',
                        ':Git diff --staged<CR>:wincmd _<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>idh',
                        ':Git diff HEAD~1 HEAD<CR>:wincmd _<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>iaa', ':Git add -u<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>iaA', ':Git add --all<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>iap', ':Git add --all --patch<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ist', ':Git status<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>isu', ':Git status -u<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>irs', ':Git reset<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>irhh', ':Git reset --hard HEAD<CR>',
                        {noremap = true})

-- for picking which files to merge from while resolving merge conflicts
-- middle is what the final merged file is
-- gj to pick hunk from the right (under right index)
-- gf to pick hunk form the left (under left index)
vim.api.nvim_set_keymap('n', '<leader>ij', ':diffget //3<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>if', ':diffget //2<CR>', {noremap = true})
