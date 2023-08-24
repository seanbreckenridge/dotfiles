-- telescope (fuzzy finder)
vim.api.nvim_set_keymap('n', '<leader>ff',
                        '<cmd>lua require("telescope.builtin").find_files()<cr>',
                        {})
vim.api.nvim_set_keymap('n', '<leader>fg',
                        '<cmd>lua require("telescope.builtin").live_grep()<cr>',
                        {})
vim.api.nvim_set_keymap('n', '<leader>fr',
                        '<cmd>lua require("telescope.builtin").lsp_references()<cr>',
                        {})
vim.api.nvim_set_keymap('n', '<leader>fb',
                        '<cmd>lua require("telescope.builtin").buffers()<cr>',
                        {})
vim.api.nvim_set_keymap('n', '<leader>fh',
                        '<cmd>lua require("telescope.builtin").help_tags()<cr>',
                        {})
vim.api.nvim_set_keymap('n', '<leader>fq',
                        '<cmd>lua require("telescope.builtin").quickfix()<cr>',
                        {})
vim.api.nvim_set_keymap('n', '<leader>fd',
                        '<cmd>lua require("telescope.builtin").loclist()<cr>',
                        {})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {})
vim.api.nvim_set_keymap('n', '<C-p>',
                        ':lua require("telescope.builtin").git_files()<CR>', {})
