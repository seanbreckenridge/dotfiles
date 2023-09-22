-- get home directory
-- vim.o sets global options, vim.opt sets buffer-local options
local os = require('os')
local home = os.getenv('HOME')
-- GLOBAL OPTIONS
vim.opt.syntax = 'on'
-- note: set nocompatible is just ignored in nvim

-- for which-key
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.updatetime = 250 -- decrease update time

-- Don't execute arbitrary modelines
vim.opt.modelines = 0
vim.opt.number = true
vim.opt.relativenumber = true -- line number
-- Blink cursor on error instead of beeping
vim.opt.visualbell = true

-- Encoding
vim.opt.encoding = 'utf-8'

-- Whitespace
vim.opt.wrap = true
vim.opt.textwidth = 0 -- stop line wrapping
vim.o.formatoptions = 'tcqrn1'
vim.o.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- cursor motion
vim.opt.scrolloff = 8
vim.opt.backspace = 'indent,eol,start'
vim.opt.matchpairs:append('<:>')
-- dont think I ever use this...
-- vim.cmd('runtime! macros/matchit.vim')

-- allow hidden buffers
vim.opt.hidden = true

-- rendering
vim.opt.ttyfast = true

-- status bar
vim.opt.laststatus = 2
vim.g.lightline = {colorscheme = 'catppuccin'}

-- last line
vim.opt.showmode = true
vim.opt.showcmd = true

-- searching
vim.opt.hlsearch = true -- highlight results on search
vim.opt.incsearch = true -- highlight as you type
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

-- https://github.com/seanbreckenridge/on_machine
vim.g.on_os = os.getenv('ON_OS') or 'unknown'

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight',
                                                    {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.highlight.on_yank() end,
    group = highlight_group,
    pattern = '*'
})

-- enable persistent undo (save undo history across file closes) if possible
if vim.fn.has("persistent_undo") == 1 then
    vim.opt.undodir = home .. '/.cache/undodir'
    vim.opt.undofile = true
end

-- path
vim.opt.path:append('**')
vim.opt.wildmenu = true
vim.opt.wildmode = {'longest', 'list', 'full'}
vim.opt.completeopt = 'menuone,noselect'
vim.opt.wildignore:append({
    '*__pycache__/*', '*.mypy_cache/*', '*.pytest_cache/*', '*egg-info/*',
    '*_build/*', '**/coverage/*', '**/node_modules/*', '**/dist/*',
    '**/build/*', '**/.git/*'
})

-- plugins
-- yadm-git
vim.g.yadm_git_verbose = 0
vim.g.yadm_git_gitgutter_enabled = 0 -- I use gitsigns instead

-- load other configuration
require "seanbreckenridge.mappings"
require "seanbreckenridge.autocmds"
require "seanbreckenridge.colorscheme"
