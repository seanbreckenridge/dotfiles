return {
    {'junegunn/goyo.vim', cmd = "Goyo"},
    -- colorscheme, 1000 makes things load early
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            local clr = require 'seanbreckenridge.colorscheme'
            clr.setup_catppuccin()
            clr.setup_theme()
        end
    }, {
        'nvim-lualine/lualine.nvim',
        priority = 1000,
        dependencies = {'nvim-tree/nvim-web-devicons'},
        opts = {options = {theme = 'dracula'}}
    }
}
