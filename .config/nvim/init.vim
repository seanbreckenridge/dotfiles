" Template from: https://gist.github.com/simonista/8703722

" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

call plug#begin('~/.local/plugged')
Plug 'junegunn/goyo.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'  " ctrl+n to use
Plug 'ludovicchabant/vim-gutentags'
Plug 'itchyny/lightline.vim'
call plug#end()

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

let mapleader =" "

" Security
set modelines=0

" Show line numbers
set number relativenumber

" Show file stats
set ruler

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

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

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
map <leader><space> :let @/=''<cr> " clear search

" prevents truncated yanks, deletes, etc.
" makes sure that you can lots of lines across
" files/vim instances without truncating the buffer
set viminfo='20,<1000,s1000

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Allow find commands to search the current directory recursively
set path+=**

" display all matching files for tab completion
set wildmenu

" mapping to toggle spellcheck
map <leader>s :set spell!<CR>

" swap to previous buffer
map <leader><leader> :bprevious<CR>

" nicer binding for window management
map <leader>w <C-W>

" Open file manager
map <leader>e :Explore<CR>

" shortcut to write and quit
map <leader>q :wq<CR>

" shortcut to quit without saving
map <leader>Q :q!<CR>

" Compile document (LaTeX/markdown/etc)
map <leader>c :w! \| !compile <c-r>%<CR><CR>
" Open corresponding .pdf/.html or preview
map <leader>o :!opout <c-r>%<CR><CR>

" copy visual selection to clipboard
vmap <leader>c "+y
vmap <leader>y "+y

" Plugins
" goyo
map <leader>g :Goyo<CR>

" fzf
map <leader>b :Buffers<CR>
map <leader>f :Files<CR>
map <leader>l :Lines<CR>
" match all lines/files recursively using the_silver_searcher
map <leader>r :Ag<CR>

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

" run set spell when editing markdown
autocmd VimEnter * if expand('%:e') == 'md' | set spell
" or when writing a git commit
autocmd BufRead,BufNewFile * if expand('%:t') == 'COMMIT_EDITMSG' | set spell
" create shortcuts, whenever I edit https://github.com/seanbreckenridge/shortcuts
autocmd BufWritePost shortcuts.toml !shortcuts create
