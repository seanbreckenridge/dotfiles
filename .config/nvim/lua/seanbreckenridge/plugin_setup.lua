-- goyo
vim.api.nvim_set_keymap('n', '<leader>YO', ':Goyo<CR>', {})

-- yadm-git
vim.g.yadm_git_verbose = 0
vim.g.yadm_git_gitgutter_enabled = 0

-- undotree
vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', {})

require('nvim-autopairs').setup {}

if vim.fn.executable('rg') == 1 then vim.g.rg_derive_root = 'true' end

-- seanbreckenridge (personal functions/plugins)
vim.api.nvim_set_keymap('n', '<leader>ce',
                        ':lua require("seanbreckenridge.edit_config").edit_config()<CR>',
                        {})

-- colors
vim.api.nvim_set_keymap('n', '<leader>ca', ':ColorizerAttachToBuffer<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>cd', ':ColorizerDetachFromBuffer<CR>', {})

require'Comment'.setup() -- gcc/gbc to comment/uncomment, gcA and gco, gcO as expected
