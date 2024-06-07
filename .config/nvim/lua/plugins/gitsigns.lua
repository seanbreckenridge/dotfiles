local has_yadm = vim.fn.executable('yadm') == 1

return {
    'lewis6991/gitsigns.nvim',
    event = {"BufReadPost", "VeryLazy"},
    dependencies = {'nvim-lua/plenary.nvim'},
    opts = {
        signs = {
            add = {text = '│'},
            change = {text = '~'},
            delete = {text = '_'},
            topdelete = {text = '‾'},
            changedelete = {text = '~'},
            untracked = {text = '┆'}
        },
        -- yadm support. checks if the current file is tracked by yadm.
        -- If it is, set the gitdir and toplevel, otherwise just return
        -- and call callback with no arguments
        _on_attach_pre = function(_, callback)
            -- a global I set on nvim launch, so I dont have to check
            -- each time this is run
            if not has_yadm then return callback() end
            vim.schedule(function()
                -- if buffer is not a file, don't change anything
                local file = vim.fn.expand('%:p')
                if not vim.fn.filereadable(file) then
                    return callback()
                end
                local repo = vim.fn.expand("~/.local/share/yadm/repo.git")
                -- use yadm ls-files to check if the file is tracked
                require('plenary.job'):new({
                    command = "yadm",
                    args = {"ls-files", "--error-unmatch", file},
                    on_exit = vim.schedule_wrap(
                        function(_, return_val)
                            if return_val == 0 then
                                return callback({
                                    gitdir = repo,
                                    toplevel = os.getenv('HOME')
                                })
                            else
                                return callback()
                            end
                        end)
                }):sync()
            end)
        end,
        on_attach = function(bufnr)
            local wk = require('which-key')

            local function map(mode, lhs, rhs, opts)
                opts = vim.tbl_extend('force', {noremap = true, silent = true},
                                      opts or {})
                vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
            end

            -- Navigation
            map('n', ']h', "&diff ? ']c' : '<Cmd>Gitsigns next_hunk<CR>'",
                {expr = true})
            map('n', '[h', "&diff ? '[c' : '<Cmd>Gitsigns prev_hunk<CR>'",
                {expr = true})

            -- Text objects
            wk.register({
                h = {
                    name = "git hunk",
                    s = {"<Cmd>Gitsigns stage_hunk<CR>", "stage hunk"},
                    r = {"<Cmd>Gitsigns reset_hunk<CR>", "reset hunk"},
                    S = {"<Cmd>Gitsigns stage_buffer<CR>", "stage buffer"},
                    R = {"<Cmd>Gitsigns reset_buffer<CR>", "reset buffer"},
                    p = {"<Cmd>Gitsigns preview_hunk<CR>", "preview hunk"},
                    b = {
                        "<Cmd>lua require'gitsigns'.blame_line{full=true}<CR>",
                        "blame line"
                    },
                    t = {
                        "<Cmd>Gitsigns toggle_current_line_blame<CR>",
                        "toggle line blame"
                    },
                    d = {"<Cmd>Gitsigns diffthis<CR>", "diff this"},
                    T = {"<Cmd>Gitsigns toggle_deleted<CR>", "toggle deleted"}
                }
            }, {prefix = '<leader>', buffer = bufnr})
        end
    }
}
