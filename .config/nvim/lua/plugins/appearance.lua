return {
    {'junegunn/goyo.vim', cmd = "Goyo"},
    {"catppuccin/nvim", name = "catppuccin", priority = 1000}, -- colorscheme, 1000 makes it load early
    'itchyny/lightline.vim', -- statusline
    {'folke/neodev.nvim', opts = {}, event = "VeryLazy"}, -- lsp hover documentation
    {'kyazdani42/nvim-web-devicons', event = "VeryLazy"} -- icons
}
