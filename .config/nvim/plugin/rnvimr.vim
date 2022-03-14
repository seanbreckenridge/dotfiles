" ranger in a vim buffer
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

