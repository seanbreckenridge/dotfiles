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
Plug 'mg979/vim-visual-multi', {'branch': 'master'}  " for tutorial: 'nvim -Nu .local/plugged/vim-visual-multi/tutorialrc'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'kevinhwang91/rnvimr'
Plug 'airblade/vim-gitgutter'
Plug 'psliwka/vim-smoothie'
Plug 'airblade/vim-rooter'
Plug 'seanbreckenridge/yadm-git.vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
call plug#end()

"""""""""""""
"           "
"  OPTIONS  "
"           "
"""""""""""""

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on
let mapleader =" "

" Dont execute arbitrary modelines
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

" mapping to toggle spellcheck
map <leader>s :set spell!<CR>

""""""""""""""""""
"                "
"  BASIC REMAPS  "
"                "
""""""""""""""""""

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

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

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


""""""""""""""""""""""""""""""
"                            "
"  WINDOW,BUFFER MANAGEMENT  "
"                            "
""""""""""""""""""""""""""""""

" swap to previous buffer
map <leader><leader> :bprevious<CR>

" nicer binding for window management
map <leader>w <C-W>
" can use <leader>w+ and <leader>w- to increase
" vertical resizing
nnoremap <leader>= :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

nnoremap <leader>+ :wincmd +<CR>
nnoremap <leader>_ :wincmd -<CR>

""""""""""""""""""""""
"                    "
"  CUSTOM FUNCTIONS  "
"                    "
""""""""""""""""""""""

" fzf docs: https://github.com/junegunn/fzf/blob/master/README-VIM.md
" like my https://sean.fish/d/ecc?dark
" edit one of my dot/config files
function! Ec()
  call fzf#run({"source": "list-config", "sink": "e"})
endfunction
map <leader>c :call Ec()<CR>
" mapping to toggle autocd
" map <leader>c :set autochdir!<CR>

" https://sean.fish/d/jumplist?dark
" jump to some directory I use often
function! Jumplist()
  call fzf#run({"source": "jumplist", "sink": "cd | Files"})
endfunction
map <leader>j :call Jumplist()<CR>


" open netrw like a sidebar file manager
nnoremap <leader>e :wincmd v<bar> :Explore <bar> :vertical resize 30<CR>
" open netrw full screen
nnoremap <leader>E :Explore<CR>


"""""""""""""
"           "
"  PLUGINS  "
"           "
"""""""""""""

function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

" goyo
map <leader>G :Goyo<CR>

" yadm
let g:yadm_git_verbose = 1

" color scheme
colorscheme tokyonight
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:tokyonight_colors = {'hint': 'orange', 'error': '#ff0000'}

" lightline configuration
let g:lightline = {
      \ 'colorscheme': 'tokyonight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" dont need this anymore since lightline displays mode
set noshowmode

" ranger
nnoremap <silent> <A-r> :RnvimrToggle<CR>
tnoremap <silent> <A-i> <C-\><C-n>:RnvimrResize<CR>
tnoremap <silent> <A-o> <C-\><C-n>:RnvimrToggle<CR>

" Map Rnvimr action
" A-r (same binding that opens rnvim
" opens the file in the parent nvim instance)
"
" can use enter as usual to open non-text files in ranger
let g:rnvimr_action = {
            \ '<A-r>': 'NvimEdit split',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }

" undotree
nnoremap <leader>u :UndotreeToggle<CR>

" fzf
map <leader>b :Buffers<CR>
map <leader>f :Files<CR>
map <leader>l :Lines<CR>
map <C-p> :GitFiles<CR>
" match all lines/files recursively using the_silver_searcher
map <leader>r :Ag<CR>

if executable('rg')
  let g:rg_derive_root='true'
endif

" jumping around the git gutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
" preview changed git hunks
nmap <leader>gP <Plug>(GitGutterPreviewHunk)

" stage hunk
nmap <leader>gA <Plug>(GitGutterStageHunk)

" fugitive (git)
nmap <leader>gi :G<CR>:wincmd _<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gll :Git pull<CR>
nmap <leader>glo :Git log<CR>
" windcmd _ full screens  can <C-W>= to reset
nmap <leader>gc :Git commit<CR>:wincmd _<CR>
nmap <leader>gdd :Git diff<CR>:wincmd _<CR>
nmap <leader>gds :Git diff --staged<CR>:wincmd _<CR>
nmap <leader>gdh :Git diff HEAD~1 HEAD<CR>:wincmd _<CR>
" --update, only add item which are already in the index
nmap <leader>gaa :Git add -u<CR>
" add everything, adds untracked files
nmap <leader>gaA :Git add --all<CR>
" add everything, but prompt me with --patch
nmap <leader>gap :Git add --all --patch<CR>
nmap <leader>gst :Git status<CR>
nmap <leader>gsu :Git status -u<CR>
nmap <leader>grs :Git reset<CR>
nmap <leader>grhh :Git reset --hard HEAD<CR>

" for picking which files to merge from while resolving merge conflicts
" https://youtu.be/PO6DxfGPQvw?t=292
" middle is what the final merged file is
" gj to pick hunk from the right (under right index)
" gf to pick hunk form the left (under left index)
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

call SourceIfExists("~/.config/nvim/coc.vim")

"""""""""""""
"           "
"  AUTOCMD  "
"           "
"""""""""""""

" run set spell when editing markdown
" dont autocomplete in markdown
autocmd VimEnter * if expand('%:e') == 'md' | set spell | let b:coc_suggest_disable = 1
" or when writing a git commit
autocmd BufRead,BufNewFile * if expand('%:t') == 'COMMIT_EDITMSG' | set spell
" create shortcuts, whenever I edit https://github.com/seanbreckenridge/shortcuts
autocmd BufWritePost shortcuts.toml !reshortcuts
" run i3-jinja to re-create i3 conf file when editing the jinja conf file
" https://sean.fish/d/config.j2?dark
autocmd BufWritePost config.j2 !i3-jinja
autocmd BufWritePost * if expand('%:f') == '.config/i3/config.yaml' | !i3-jinja
