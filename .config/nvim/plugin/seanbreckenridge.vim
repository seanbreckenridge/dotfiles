command Ec :call seanbreckenridge#edit_config()
command Jump :call seanbreckenridge#jumplist()

" from coc.nvim
function! ShowDocumentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    echo 'Not in vim configuration!'
  endif
endfunction

nnoremap <silent> K :call ShowDocumentation()<CR>
