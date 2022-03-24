" git related bindings

" fugitive (git)
nmap <leader>G :G<CR>:wincmd _<CR>
nmap <leader>ip :Git push<CR>
nmap <leader>ill :Git pull<CR>
nmap <leader>ilo :Git log<CR>
" windcmd _ full screens  can <C-W>= to reset
nmap <leader>ic :Git commit<CR>:wincmd _<CR>
nmap <leader>idd :Git diff<CR>:wincmd _<CR>
nmap <leader>ids :Git diff --staged<CR>:wincmd _<CR>
nmap <leader>idh :Git diff HEAD~1 HEAD<CR>:wincmd _<CR>
" --update, only add item which are already in the index
nmap <leader>iaa :Git add -u<CR>
" add everything, adds untracked files
nmap <leader>iaA :Git add --all<CR>
" add everything, but prompt me with --patch
nmap <leader>iap :Git add --all --patch<CR>
nmap <leader>ist :Git status<CR>
nmap <leader>isu :Git status -u<CR>
nmap <leader>irs :Git reset<CR>
nmap <leader>irhh :Git reset --hard HEAD<CR>

" for picking which files to merge from while resolving merge conflicts
" https://youtu.be/PO6DxfGPQvw?t=292
" middle is what the final merged file is
" gj to pick hunk from the right (under right index)
" gf to pick hunk form the left (under left index)
nmap <leader>ij :diffget //3<CR>
nmap <leader>if :diffget //2<CR>
