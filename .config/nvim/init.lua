-- Helps force plugins to load correctly when it is turned back on below
vim.cmd('filetype off')

-- needs to be before the plugin is loaded
vim.g.polyglot_disabled = {'org'}

-- left here as a last resort if the LSP config didnt work, but this can be configured
-- through capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
--
-- watchfiles implementation crashes my machine if there are too many files in the project
-- local ok, wf = pcall(require, "vim.lsp._watchfiles")
-- if ok then
--     -- disable lsp watcher. Too slow on linux
--     wf._watchfunc = function() return function() end end
-- end

-- load plugins/lua
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- cache lua startup by maintaining a bytecode/module resolution cache
    use 'lewis6991/impatient.nvim'

    -- utility/feature plugins
    use 'junegunn/goyo.vim'
    use {'nvim-telescope/telescope.nvim', tag = '0.1.1'}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-context'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {"catppuccin/nvim", as = "catppuccin"}
    use 'tpope/vim-fugitive'
    -- use 'tpope/vim-sleuth'
    use 'mbbill/undotree'
    use {'mg979/vim-visual-multi', branch = 'master'} -- for tutorial: 'nvim -Nu .local/plugged/vim-visual-multi/tutorialrc'
    use 'airblade/vim-rooter'
    use 'seanbreckenridge/yadm-git.vim'
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use 'psliwka/vim-smoothie'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-repeat'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-speeddating'
    use 'numToStr/Comment.nvim'
    use 'L3MON4D3/LuaSnip'
    use 'github/copilot.vim'
    use 'norcalli/nvim-colorizer.lua'
    use 'windwp/nvim-autopairs'

    -- languages/syntax/snippets
    use 'fladson/vim-kitty'
    use 'sbdchd/neoformat'
    use 'jceb/vim-orgmode'
    use 'sheerun/vim-polyglot'
    use 'rafamadriz/friendly-snippets'

    -- Appearance
    -- Statusline
    use 'itchyny/lightline.vim'
    -- Startup
    use 'kyazdani42/nvim-web-devicons'
    use 'goolord/alpha-nvim'

    -- LSP/Diagnostic Clients
    use 'hrsh7th/nvim-cmp'
    use 'mfussenegger/nvim-lint'

    -- LSP - some basics
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'

    -- LSP - icons
    use 'onsails/lspkind.nvim'

    -- LSP - snippets
    use 'saadparwaiz1/cmp_luasnip'

    -- LSP - language/syntax specific
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'tamago324/cmp-zsh'

    use 'folke/which-key.nvim'
end)

require('impatient')

-- For plugins to load correctly
vim.cmd 'filetype plugin indent on'

-- load my lua configuration -- i.e. the rest of my configuration that doesnt have anything to do with installing plugins
require 'seanbreckenridge'
