" git related bindings

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
