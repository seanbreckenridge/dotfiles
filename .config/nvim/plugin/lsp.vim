" lsp bindings

nnoremap <silent> ]e :lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>
nnoremap <silent> [e :lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>

nnoremap <silent> ]w :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> [w :lua vim.diagnostic.goto_prev()<CR>
