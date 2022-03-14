command Ec :call seanbreckenridge#edit_config()
command Jump :call seanbreckenridge#jumplist()

" from coc.nvim
function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    :lua vim.lsp.buf.hover()
  endif
endfunction

nnoremap <silent> K :call ShowDocumentation()<CR>
