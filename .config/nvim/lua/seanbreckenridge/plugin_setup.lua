-- yadm-git
vim.g.yadm_git_verbose = 0
vim.g.yadm_git_gitgutter_enabled = 0

local wk = require('which-key')

wk.register({u = {'<cmd>UndotreeToggle<cr>', 'undotree'}}, {prefix = '<leader>'})

require('nvim-autopairs').setup {}

if vim.fn.executable('rg') == 1 then vim.g.rg_derive_root = 'true' end

-- seanbreckenridge (personal functions/plugins)
wk.register({
    -- can change this to a different prefix if something ever conflicts
    c = {
        name = "change files",
        e = {require("seanbreckenridge.pick").edit_config, 'edit config'},
        r = {require("telescope").extensions.repo.list, 'switch repo'}
    }
}, {prefix = '<leader>'})

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

require('Comment').setup() -- gcc/gbc to comment/uncomment, gcA and gco, gcO as expected

require('neodev').setup()
