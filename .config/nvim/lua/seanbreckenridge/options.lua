-- get home directory
local os = require('os')
local home = os.getenv('HOME')
-- GLOBAL OPTIONS
vim.o.syntax = 'on'
vim.g.mapleader = ' '

-- Don't execute arbitrary modelines
vim.o.modelines = 0
vim.wo.number = true
vim.wo.relativenumber = true -- line number
-- Blink cursor on error instead of beeping
vim.o.visualbell = true

-- Encoding
vim.o.encoding = 'utf-8'

-- Whitespace
vim.o.wrap = true
vim.o.textwidth = 0 -- stop line wrapping
vim.o.formatoptions = 'tcqrn1'
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- cursor motion
vim.opt.scrolloff = 3
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
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true

-- visualize tabs and newlines
vim.opt.list = true
vim.opt.listchars:append({tab = '▸ ', eol = '¬'})

-- prevents truncated yanks, deletes, etc.
-- makes sure that you can have lots of lines across
-- files/vim instances without truncating the buffer
vim.opt.viminfo = "'20,<1000,s1000"

-- enable persistent undo (save undo history across file closes) if possible
if vim.fn.has("persistent_undo") == 1 then
    vim.opt.undodir = home .. '/.cache/undodir'
    vim.opt.undofile = true
end

-- path
vim.opt.path:append('**')
vim.opt.wildmenu = true
vim.opt.wildmode = {'longest', 'list', 'full'}
vim.opt.wildignore:append({
    '*__pycache__/*', '*.mypy_cache/*', '*.pytest_cache/*', '*egg-info/*',
    '*_build/*', '**/coverage/*', '**/node_modules/*', '**/dist/*',
    '**/build/*', '**/.git/*'
})
