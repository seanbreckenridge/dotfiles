" lsp bindings

nnoremap <silent> ]w :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> [w :lua vim.diagnostic.goto_prev()<CR>

nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> rn :lua vim.lsp.buf.rename()<CR>
" leader<t> is format, so this is logical
nnoremap <silent> <leader>T :lua vim.lsp.buf.code_action()<CR>

function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    lua vim.lsp.buf.hover()
  endif
endfunction

augroup seanbreckenridge_lsp
  autocmd!
  autocmd! BufWrite,BufEnter,InsertLeave * :lua vim.diagnostic.setloclist({open=false, severity = {min=vim.diagnostic.severity.HINT}})
augroup END

nnoremap <silent> K :call ShowDocumentation()<CR>

" copilot
" remove tab mapping -- map to alt+c
" to swap between choices, use alt+] and alt+[
imap <silent><script><expr> <M-c> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

let g:copilot_filetypes = {'*': v:true }
