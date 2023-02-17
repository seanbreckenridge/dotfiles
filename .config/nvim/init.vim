" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" needs to be before the plugin is loaded
let g:polyglot_disabled = ['org']

" load plugins/lua

call plug#begin('~/.local/share/plugged')
" cache lua startup by maintaining a bytecode/module resolution cache
Plug 'lewis6991/impatient.nvim'

" utility/feature plugins
Plug 'junegunn/goyo.vim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'kevinhwang91/rnvimr'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}  " for tutorial: 'nvim -Nu .local/plugged/vim-visual-multi/tutorialrc'
Plug 'airblade/vim-rooter'
Plug 'seanbreckenridge/yadm-git.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'psliwka/vim-smoothie'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-speeddating'
Plug 'numToStr/Comment.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'github/copilot.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'windwp/nvim-autopairs'

" languages/syntax/snippets
Plug 'fladson/vim-kitty'
Plug 'sbdchd/neoformat'
Plug 'jceb/vim-orgmode'
Plug 'sheerun/vim-polyglot'
Plug 'rafamadriz/friendly-snippets'
Plug 'honza/vim-snippets'

" appearance
" statusline
Plug 'itchyny/lightline.vim'
" startup
Plug 'kyazdani42/nvim-web-devicons'
Plug 'goolord/alpha-nvim'

" lsp/diagnostic clients
Plug 'hrsh7th/nvim-cmp'
Plug 'mfussenegger/nvim-lint'

" lsp - some basics
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-path'

" lsp - icons
Plug 'onsails/lspkind.nvim'

" lsp - snippets
Plug 'saadparwaiz1/cmp_luasnip'

" lsp - language/syntax specific
Plug 'neovim/nvim-lspconfig' " community config for lsp servers, loaded in ./after/plugin/lsp.lua
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'tamago324/cmp-zsh'
call plug#end()

lua require('impatient')


" For plugins to load correctly
filetype plugin indent on
let g:do_filetype_lua = 1

" load my lua configuration -- i.e. my init.lua
lua require("seanbreckenridge")

"""""""""""""
"           "
"  OPTIONS  "
"           "
"""""""""""""

syntax on
let mapleader =" "

" Don't execute arbitrary modelines
set modelines=0
set number relativenumber  " line number
" Blink cursor on error instead of beeping
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=0  wrapmargin=0" stop line wrapping
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set smartindent
" Give more space for displaying messages.
set cmdheight=2

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2
let g:lightline = { 'colorscheme': 'catppuccin' }

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬

" prevents truncated yanks, deletes, etc.
" makes sure that you can lots of lines across
" files/vim instances without truncating the buffer
set viminfo='20,<1000,s1000

" enable persistent undo (save undo history across file closes) if possible
if has("persistent_undo")
  set undodir=$HOME/.cache/undodir
  set undofile
endif

""""""""""
"        "
"  PATH  "
"        "
""""""""""

" Allow find commands to search the current directory recursively
set path+=**

" display all matching files for tab completion
set wildmenu
set wildmode=longest,list,full
" Ignore files
set wildignore+=*__pycache__/*
set wildignore+=*.mypy_cache/*
set wildignore+=*.pytest_cache/*
set wildignore+=*egg-info/*
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/dist/*
set wildignore+=**/build/*
set wildignore+=**/.git/*

""""""""""""""
"            "
"  MAPPINGS  "
"            "
""""""""""""""

" mapping to toggle spellcheck
map <leader>s :set spell!<CR>

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Wrap long lines of text (use Qq to run)
" (obviously, 5Qq to do multiple lines)
nnoremap Q gq

" center/fix cursor when jumping around text
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" disable arrow keys
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" copy visual selection to clipboard
vmap <leader>c "+y
vmap <leader>y "+y
nnoremap <leader>y V"+y

" open netrw like a sidebar file manager
nnoremap <leader>e :wincmd v<bar> :Explore <bar> :vertical resize 30<CR>
" open netrw full screen
nnoremap <leader>E :Explore<CR>
" resource config
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>:lua require('seanbreckenridge.colors').setup_theme()<CR>

" quickfix lists
nnoremap <leader>gj :cnext<CR>zz
nnoremap <leader>gk :cprev<CR>zz
nnoremap <leader>j :lnext<CR>zz
nnoremap <leader>k :lprev<CR>zz

nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <leader>q :call ToggleQFList(0)<CR>

let g:seanbreckenridge_qf_l = 0
let g:seanbreckenridge_qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:seanbreckenridge_qf_g == 1
            let g:seanbreckenridge_qf_g = 0
            cclose
        else
            let g:seanbreckenridge_qf_g = 1
            copen
        end
    else
        if g:seanbreckenridge_qf_l == 1
            let g:seanbreckenridge_qf_l = 0
            lclose
        else
            let g:seanbreckenridge_qf_l = 1
            lopen
        end
    endif
endfun

" window/buffers

" swap between buffers
nnoremap <leader>b <C-^><CR>

" nicer binding for window management
map <leader>w <C-W>
" can use <leader>w+ and <leader>w- to increase
" vertical resizing
nnoremap <leader>= :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

nnoremap <leader>+ :wincmd +<CR>
nnoremap <leader>_ :wincmd -<CR>

""""""""""""""""""""""""""
"                        "
"  PLUGIN CONFIGURATION  "
"                        "
""""""""""""""""""""""""""

" Note: more extensive plugins have their own file in plugin/

" goyo
map <leader>YO :Goyo<CR>

" yadm-git
let g:yadm_git_verbose = 0
let g:yadm_git_gitgutter_enabled = 0

" undotree
nnoremap <leader>u :UndotreeToggle<CR>

" telescope (fuzzy finder)
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
" Ctrl+q while in telescope to send to quickfix list
nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfix()<cr>
" diagnostic (builtin nvim lsp) list
nnoremap <leader>fd <cmd>lua require('telescope.builtin').loclist()<cr>

nnoremap <leader>fb <cmd>Telescope buffers<cr>
map <C-p> :lua require('telescope.builtin').git_files()<CR>

lua require('nvim-autopairs').setup{}

if executable('rg')
  let g:rg_derive_root='true'
endif

" seanbreckenridge (personal functions/plugins)
map <leader>ce <cmd>:lua require('seanbreckenridge.edit_config').edit_config()<CR>

" colors
map <leader>ca :ColorizerAttachToBuffer<CR>
map <leader>cd :ColorizerDetachFromBuffer<CR>

"""""""""""""
"           "
"  AUTOCMD  "
"           "
"""""""""""""

" check spelling when writing a git commit
augroup seanbreckenridge_spelling
    autocmd!
    autocmd! BufRead,BufNewFile gitcommit | set spell
    autocmd! BufWritePost lua require('lint').try_lint()
augroup END
