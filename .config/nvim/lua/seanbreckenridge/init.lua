-- get home directory
local os = require('os')
local home = os.getenv('HOME')
-- GLOBAL OPTIONS
vim.opt.syntax = 'on'

-- for which-key
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.updatetime = 250 -- decreate update time

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
vim.cmd('runtime! macros/matchit.vim')

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
vim.api.nvim_set_keymap('n', '/', '/\\v', {noremap = true})
vim.api.nvim_set_keymap('v', '/', '/\\v', {noremap = true})
vim.opt.hlsearch = true -- highlight on search
vim.opt.incsearch = true
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
vim.g.on_os = os.getenv('ON_OS')

-- sync clipboard with system clipboard, if im not on android (takes too long on there and sends system notifications that are annoying)
if string.find(vim.g.on_os, 'android') then
    vim.opt.clipboard = ''
else
    vim.opt.clipboard = 'unnamedplus'
end

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
vim.g.yadm_git_gitgutter_enabled = 0

-- formatting
vim.g.neoformat_enabled_python = {'black'}
vim.g.neoformat_enabled_html = {'prettier'}
vim.g.neoformat_enabled_javascript = {'prettier'}
vim.g.neoformat_enabled_typescript = {'prettier'}
vim.g.neoformat_enabled_json = {'prettier'}

require "seanbreckenridge.catppuccin" -- source colorscheme
