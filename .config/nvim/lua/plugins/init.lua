-- change directory in the window's local directory instead of the whole application
vim.g.rooter_cd_cmd = "lcd"

return {
    {"folke/which-key.nvim", lazy = true}, -- keybindings
    {"machakann/vim-sandwich", keys = {"sa", "sr", "sd"}}, -- surround text (e.g. quotes/brackets)
    -- []x to encode/decode HTML, []u to encode/decode URLs, []y to do C-style escaping
    {
        "seanbreckenridge/vim-unimpaired-conversions",
        keys = {"[", "]"}
        -- dir = "~/Files/OldRepos/vim-unimpaired-conversions"
    }, {"tpope/vim-sleuth", event = "VeryLazy"}, -- detect indentation
    {"airblade/vim-rooter", event = "VeryLazy"}
}
