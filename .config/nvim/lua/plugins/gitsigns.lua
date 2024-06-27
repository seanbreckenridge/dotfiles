return {
    {
        "seanbreckenridge/gitsigns-yadm.nvim",
        -- dir = "~/Repos/gitsigns-yadm.nvim",
        -- opts = {},
        lazy = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "VeryLazy" },
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            _on_attach_pre = function(_, callback)
                if vim.fn.executable("yadm") == 1 then
                    -- leaving the schedule here so that I notice breaking
                    -- changes if any happen. otherwise gitsigns might suppress
                    -- errors that happen in _on_attach_pre
                    vim.schedule(function()
                        require("gitsigns-yadm").yadm_signs(callback)
                    end)
                else
                    callback()
                end
            end,
            on_attach = function(bufnr)
                local wk = require("which-key")

                local function map(mode, lhs, rhs, opts)
                    opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
                    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                end

                -- Navigation
                map("n", "]h", "&diff ? ']c' : '<Cmd>Gitsigns next_hunk<CR>'", { expr = true })
                map("n", "[h", "&diff ? '[c' : '<Cmd>Gitsigns prev_hunk<CR>'", { expr = true })

                -- Text objects
                wk.register({
                    h = {
                        name = "git hunk",
                        s = { "<Cmd>Gitsigns stage_hunk<CR>", "stage hunk" },
                        r = { "<Cmd>Gitsigns reset_hunk<CR>", "reset hunk" },
                        S = { "<Cmd>Gitsigns stage_buffer<CR>", "stage buffer" },
                        R = { "<Cmd>Gitsigns reset_buffer<CR>", "reset buffer" },
                        p = { "<Cmd>Gitsigns preview_hunk<CR>", "preview hunk" },
                        b = {
                            "<Cmd>lua require'gitsigns'.blame_line{full=true}<CR>",
                            "blame line",
                        },
                        t = {
                            "<Cmd>Gitsigns toggle_current_line_blame<CR>",
                            "toggle line blame",
                        },
                        d = { "<Cmd>Gitsigns diffthis<CR>", "diff this" },
                        T = { "<Cmd>Gitsigns toggle_deleted<CR>", "toggle deleted" },
                    },
                }, { prefix = "<leader>", buffer = bufnr })
            end,
        },
    },
}
