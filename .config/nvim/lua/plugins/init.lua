return {
    'folke/which-key.nvim', -- keybindings
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = {'nvim-lua/plenary.nvim'}
    }, {'junegunn/goyo.vim', cmd = "Goyo"}, -- distraction free writing
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'}, -- syntax highlighting
    'nvim-treesitter/nvim-treesitter-context', -- treesitter context
    {"catppuccin/nvim", name = "catppuccin", priority = 1000}, -- colorscheme, 1000 makes it load early
    'tpope/vim-fugitive', -- git integration
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make', lazy = true}, -- telescope fzf integration
    {'cljoly/telescope-repo.nvim', lazy = true}, -- telescope repo/project integration
    'mbbill/undotree', -- undo tree
    {'mg979/vim-visual-multi', branch = 'master'}, -- for tutorial: 'nvim -Nu .local/plugged/vim-visual-multi/tutorialrc'
    'airblade/vim-rooter', -- changes directory to root of project
    'seanbreckenridge/yadm-git.vim', -- yadm integration
    'psliwka/vim-smoothie', -- smooth scrolling
    'tpope/vim-surround', -- surround text objects
    'tpope/vim-unimpaired', -- pairs of handy bracket mappings
    'tpope/vim-repeat', -- repeat plugin commands
    'tpope/vim-vinegar', -- nicer netrw commands
    {'tpope/vim-speeddating', keys = {"<C-a>", "<C-x>"}}, -- increment/decrement dates
    {'windwp/nvim-autopairs', event = "InsertEnter"}, -- auto pair brackets
    -- all the comment.nvim mappings start with 'g', so don't load anything till I press 'g'
    'numToStr/Comment.nvim', -- language aware comment/uncomment lines
    'github/copilot.vim', -- github copilot integration
    'norcalli/nvim-colorizer.lua', -- colorize hex codes
    -- languages/syntax
    'sbdchd/neoformat', -- format code
    'fladson/vim-kitty', -- kitty syntax highlighting
    'jceb/vim-orgmode', -- orgmode syntax highlighting
    -- Appearance
    -- Statusline
    'itchyny/lightline.vim', -- statusline
    {'folke/neodev.nvim', config = true}, -- lsp hover documentation
    -- Startup
    'kyazdani42/nvim-web-devicons', -- icons
    -- LSP/Diagnostic Clients
    'hrsh7th/nvim-cmp', -- completion
    'mfussenegger/nvim-lint', -- linting with vim.diagnostic
    'hrsh7th/cmp-buffer', -- completes words from open buffers
    -- 'hrsh7th/cmp-cmdline', -- completes vim commands
    'hrsh7th/cmp-path', -- completes file paths
    'onsails/lspkind.nvim', -- icons for lsp completion
    'saadparwaiz1/cmp_luasnip', -- completion for snippets
    -- LSP - language/syntax specific
    'neovim/nvim-lspconfig', -- lsp configuration defaults
    'hrsh7th/cmp-nvim-lsp', -- lsp completion
    'tamago324/cmp-zsh' -- zsh completion
}
