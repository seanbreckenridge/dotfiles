-- change directory in the window's local directory instead of the whole application
vim.g.rooter_cd_cmd = 'lcd'

return {
    {'folke/which-key.nvim'}, -- keybindings
    -- yadm integration (needs to be loaded early since uses BufWinEnter to detect)
    -- if yadm is not installed, this will be disabled
    {
        'seanbreckenridge/yadm-git.vim',
        cond = vim.g.has_yadm,
        -- dir = "~/Files/OldRepos/yadm-git.vim",
        event = "BufWinEnter",
        config = function()
            vim.g.yadm_git_verbose = 0
            vim.g.yadm_git_gitgutter_enabled = 0 -- I use gitsigns instead
        end
    }, {"machakann/vim-sandwich", keys = {"sa", "sr", "sd"}}, -- surround text (e.g. quotes/brackets)
    -- []x to encode/decode HTML, []u to encode/decode URLs, []y to do C-style escaping
    {'seanbreckenridge/vim-unimpaired-conversions', keys = {"[", "]"}},
    {'tpope/vim-sleuth', event = "VeryLazy"}, -- detect indentation
    {'tpope/vim-speeddating', keys = {"<C-a>", "<C-x>"}}, -- increment/decrement dates
    {'airblade/vim-rooter', event = "VeryLazy"}
}
