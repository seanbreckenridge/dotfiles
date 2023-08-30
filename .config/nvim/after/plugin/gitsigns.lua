-- Git related bindings
require('gitsigns').setup {
    signs = {
        add = {text = '+'},
        change = {text = '~'},
        delete = {text = '_'},
        topdelete = {text = '‾'},
        changedelete = {text = '~'}
    },
    on_attach = function(bufnr)

        local wk = require('which-key')

        local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend('force', {noremap = true, silent = true},
                                  opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        -- Navigation
        map('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",
            {expr = true})
        map('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
            {expr = true})

        -- Text objects
        wk.register({
            h = {
                name = "git hunk",
                s = {"<cmd>Gitsigns stage_hunk<CR>", "stage hunk"},
                r = {"<cmd>Gitsigns reset_hunk<CR>", "reset hunk"},
                S = {"<cmd>Gitsigns stage_buffer<CR>", "stage buffer"},
                R = {"<cmd>Gitsigns reset_buffer<CR>", "reset buffer"},
                p = {"<cmd>Gitsigns preview_hunk<CR>", "preview hunk"},
                b = {
                    "<cmd>lua require'gitsigns'.blame_line{full=true}<CR>",
                    "blame line"
                },
                t = {
                    "<cmd>Gitsigns toggle_current_line_blame<CR>",
                    "toggle line blame"
                },
                d = {"<cmd>Gitsigns diffthis<CR>", "diff this"},
                T = {"<cmd>Gitsigns toggle_deleted<CR>", "toggle deleted"}
            }
        }, {prefix = '<leader>', buffer = bufnr})
    end,
    -- yadm
    yadm = {enable = true}
    --
}
