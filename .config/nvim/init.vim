" Template from: https://gist.github.com/simonista/8703722

" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

call plug#begin('~/.local/plugged')
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdtree'
Plug 'elixir-editors/vim-elixir'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'ludovicchabant/vim-gutentags'
Plug 'cespare/vim-toml'
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

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

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

" Plugins
" Nerdtree
map <leader>w :NERDTreeToggle<CR>

" goyo
map <leader>g :Goyo<CR>

" fzf
map <leader>b :Buffers<CR>
map <leader>f :Files<CR>
map <leader>l :Lines<CR>
" match all lines/files recursively using the_silver_searcher
map <leader>r :Ag<CR>
map <leader>c :Commands<CR>
