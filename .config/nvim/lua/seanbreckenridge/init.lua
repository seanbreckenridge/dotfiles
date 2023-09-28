-- get home directory
-- vim.o sets global options, vim.opt sets buffer-local options
-- see :help vim-differences for some defaults set in nvim
-- for :help syntax, treesitter will disable this for filetypes it knows, otherwise
-- syntax highlighting is enabled by default

-- Don't execute arbitrary modelines
vim.opt.modelines = 0
vim.opt.number = true
vim.opt.relativenumber = true -- line number
-- Blink cursor on error instead of beeping
vim.opt.visualbell = true

-- Whitespace
vim.opt.wrap = true
vim.opt.textwidth = 0 -- stop line wrapping
vim.o.formatoptions = 'tcqrn1'

-- set tab config local to buffer
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- cursor motion
vim.opt.scrolloff = 8
vim.opt.matchpairs:append('<:>')
-- dont think I ever use this...
-- vim.cmd('runtime! macros/matchit.vim')

-- save spellfile to my Documents
local os = require('os')
local spellfile = os.getenv('NVIM_SPELLFILE')
if spellfile then vim.o.spellfile = spellfile end

-- only show status line for last window
vim.opt.laststatus = 3

-- transparency
vim.opt.pumblend = 10
vim.opt.winblend = 10

-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true

-- spacing/tabs/newlines
vim.opt.list = true
vim.opt.listchars:append({tab = '▸ ', eol = '¬'})
vim.opt.breakindent = true -- wrapped lines indent
vim.opt.signcolumn = 'yes'

-- prevents truncated yanks, deletes, etc.
-- makes sure that you can have lots of lines across
-- files/vim instances without truncating the buffer
vim.opt.viminfo = "'20,<1000,s1000"

-- marks
vim.opt.shada = "'1000,f1,<100"

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight',
                                                    {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*'
})

-- enable persistent undo (save undo history across file closes) if possible
vim.opt.undofile = true

-- path
vim.opt.path:append('**')
vim.opt.wildmode = {'longest', 'list', 'full'}
vim.opt.completeopt = 'menuone,noselect'
vim.opt.wildignore:append({
    '*__pycache__/*', '*.mypy_cache/*', '*.pytest_cache/*', '*egg-info/*',
    '*_build/*', '**/coverage/*', '**/node_modules/*', '**/dist/*',
    '**/build/*', '**/.git/*'
})

-- load other configuration
require "seanbreckenridge.mappings"
require "seanbreckenridge.autocmds"
require "seanbreckenridge.colorscheme"
