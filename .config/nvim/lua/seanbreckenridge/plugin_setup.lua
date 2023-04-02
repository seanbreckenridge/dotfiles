-- goyo
vim.api.nvim_set_keymap('n', '<leader>YO', ':Goyo<CR>', {})

-- yadm-git
vim.g.yadm_git_verbose = 0
vim.g.yadm_git_gitgutter_enabled = 0

-- undotree
vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', {})

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

require('nvim-autopairs').setup {}

if vim.fn.executable('rg') == 1 then vim.g.rg_derive_root = 'true' end

-- seanbreckenridge (personal functions/plugins)
vim.api.nvim_set_keymap('n', '<leader>ce',
                        ':lua require("seanbreckenridge.edit_config").edit_config()<CR>',
                        {})

-- colors
vim.api.nvim_set_keymap('n', '<leader>ca', ':ColorizerAttachToBuffer<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>cd', ':ColorizerDetachFromBuffer<CR>', {})

