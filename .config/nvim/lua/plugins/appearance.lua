return {
    {'junegunn/goyo.vim', cmd = "Goyo"},
    -- colorscheme, 1000 makes things load early
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require'seanbreckenridge.colorscheme'.setup_catppuccin()
        end
    }, {
        'nvim-lualine/lualine.nvim',
        priority = 1000,
        depends = {'nvim-tree/nvim-web-devicons'},
        opts = {options = {theme = 'dracula'}}
    }
}
