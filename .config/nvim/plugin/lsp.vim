" lsp bindings

nnoremap <silent> ]e :lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>
nnoremap <silent> [e :lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>

nnoremap <silent> ]w :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> [w :lua vim.diagnostic.goto_prev()<CR>

function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    lua vim.lsp.buf.hover()
  endif
endfunction

nnoremap <silent> K :call ShowDocumentation()<CR>
