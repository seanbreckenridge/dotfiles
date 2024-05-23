-- change directory in the window's local directory instead of the whole application
vim.g.rooter_cd_cmd = 'lcd'

return {
    {'folke/which-key.nvim', lazy = true}, -- keybindings
    -- yadm integration (needs to be loaded early since uses BufWinEnter to detect)
    -- if yadm is not installed, this will be disabled
    {
        'seanbreckenridge/yadm-git.vim',
        enabled = vim.g.has_yadm,
        event = "VeryLazy",
        -- dir = "/home/sean/Files/OldRepos/yadm-git.vim",
        config = function()
            vim.g.yadm_git_verbose = 0
            vim.g.yadm_git_gitgutter_enabled = 0 -- I use gitsigns instead
        end
    }, {"machakann/vim-sandwich", keys = {"sa", "sr", "sd"}}, -- surround text (e.g. quotes/brackets)
    -- vim-unimpaired reminders:
    -- []f to go to next/prev file
    -- []q quickfix, , []Space to add newlines, []e to swap lines
    -- []xx to encode/decode HTML, []uu to encode/decode URLs, []y to do C-style escaping
    {'tpope/vim-unimpaired', keys = {"]", "["}},
    {'tpope/vim-repeat', event = "VeryLazy"}, -- repeat plugin commands
    {'tpope/vim-sleuth', event = "VeryLazy"}, -- detect indentation
    {'tpope/vim-speeddating', keys = {"<C-a>", "<C-x>"}}, -- increment/decrement dates
    {'airblade/vim-rooter', event = "VeryLazy"}, {
        -- g? : show help
        "stevearc/oil.nvim",
				event = "VeryLazy",
				-- hmm.. doesn't seem to work when trying to trigger multiple times
        -- keys = "<leader>e",
        -- cmd = "Oil",
        opts = {
            default_file_explorer = true,
            columns = {"icon"},
            delete_to_trash = true
        }
    }

}
