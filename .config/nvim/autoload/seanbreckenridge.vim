" fzf docs: https://github.com/junegunn/fzf/blob/master/README-VIM.md
" like my https://sean.fish/d/ecc?dark
" edit one of my dot/config files
function seanbreckenridge#edit_config()
  call fzf#run({"source": "list-config", "sink": "e"})
endfunction

" https://sean.fish/d/jumplist?dark
" jump to some directory I use often
function! seanbreckenridge#jumplist()
  call fzf#run({"source": "jumplist", "sink": "cd | Files"})
endfunction
