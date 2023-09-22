return {
    {'folke/which-key.nvim', lazy = true}, -- keybindings
    {'junegunn/goyo.vim', cmd = "Goyo"}, -- distraction free writing
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = {"nvim-treesitter/nvim-treesitter"}
    }, -- treesitter context
    {"catppuccin/nvim", name = "catppuccin", priority = 1000}, -- colorscheme, 1000 makes it load early
    {'seanbreckenridge/yadm-git.vim', enabled = vim.g.has_yadm}, -- yadm integration (needs to be loaded early since uses BufWinEnter to detect)
    {"machakann/vim-sandwich", event = "VeryLazy"}, -- operations on selected text
    -- vim-unimpaired reminders:
    -- []f to go to next/prev file
    -- []q quickfix, , []Space to add newlines, []e to swap lines
    -- []xx to encode/decode HTML, []uu to encode/decode URLs, []y to do C-style escaping
    {'tpope/vim-unimpaired', event = "VeryLazy"},
    {'tpope/vim-repeat', event = "VeryLazy"}, -- repeat plugin commands
    {'tpope/vim-sleuth'}, -- detect indentation
    -- '-' to go up, '~' to go home, y. to yank filename, . to put file on command line
    {'tpope/vim-vinegar', event = "VeryLazy"}, -- nicer netrw commands
    {'github/copilot.vim', event = "VeryLazy"},
    {'tpope/vim-speeddating', keys = {"<C-a>", "<C-x>"}}, -- increment/decrement dates
    {'windwp/nvim-autopairs', event = "InsertEnter", opts = {}}, -- auto pair brackets
    {'numToStr/Comment.nvim', opts = {}, event = "VeryLazy"}, -- language aware comment/uncomment lines
    -- languages/syntax
    {'fladson/vim-kitty', ft = 'kitty'}, -- kitty config file
    {'jceb/vim-orgmode', ft = 'org', dependencies = {"tpope/vim-speeddating"}}, -- orgmode
    -- Appearance
    -- Statusline
    'itchyny/lightline.vim', -- statusline
    {'folke/neodev.nvim', opts = {}, event = "VeryLazy"}, -- lsp hover documentation
    -- Startup
    {'kyazdani42/nvim-web-devicons', event = "VeryLazy"} -- icons
}
