return {
    -- keybindings
    {
        "folke/which-key.nvim",
        lazy = true,
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    -- []x to encode/decode HTML, []u to encode/decode URLs, []y to do C-style escaping
    {
        "seanbreckenridge/vim-unimpaired-conversions",
        keys = { "[", "]" },
        -- dir = "~/Files/OldRepos/vim-unimpaired-conversions"
    },
    {
        "airblade/vim-rooter",
        event = "BufWinEnter",
        init = function()
            -- change directory in the window's local directory instead of the whole application
            vim.g.rooter_cd_cmd = "lcd"
            vim.g.rooter_patterns = {
                ".git",
                "Makefile",
                "setup.py",
                "package.json",
                "stylua.toml",
            }
        end,
    },
}
