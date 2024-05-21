return {
    {
        'folke/zen-mode.nvim',
        dependencies = {'folke/twilight.nvim'},
        cmd = "ZenMode",
        opts = {}
    }, {
        "catppuccin/nvim",
        name = "catppuccin",
        -- colorscheme, 1000 makes things load early
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                background = {light = "latte", dark = "macchiato"},
                -- change background colors to match terminal
                color_overrides = {
                    macchiato = {base = "#282828"},
                    latte = {base = "#fbf1c7"}
                }
            })
            vim.cmd.colorscheme 'catppuccin'
        end
    }, {
        'nvim-lualine/lualine.nvim',
        priority = 1000,
        dependencies = {'nvim-tree/nvim-web-devicons'},
        opts = {options = {theme = 'catppuccin'}}
    }, {'j-hui/fidget.nvim', event = "LspAttach", opts = {}},
    {{'stevearc/dressing.nvim', opts = {}}}
}
