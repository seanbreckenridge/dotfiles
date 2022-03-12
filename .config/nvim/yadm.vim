" use yadm ls-files to detect if the current file I'm editing is one of my
" dotfiles
"
" patch git executable path for git fugitive and git gitter, so I can
" add hunks/commit dotfiles from within vim

let g:yadm_repo_path="~/.local/share/yadm/repo.git"

function! YadmCheckGitFile()
  " use yadm ls-files to check if the current file is tracked by yadm as one of my dotfiles
  " jobstart runs async
  call jobstart(['yadm', 'ls-files', '--error-unmatch', expand('%:p')], {'on_exit':{j,d,e->YadmDetectDir(d)}})
endfunction

" callback from anonymous function above, receives the exit status
function! YadmDetectDir(exit_status)
  if a:exit_status == 0
    " exited successfully, this is one of my dotfiles
    " detect with fugitive
    call FugitiveDetect(g:yadm_repo_path)
    let g:gitgutter_git_executable='yadm'
    echo "yadm: detected file as dotfile"
  else
    if g:gitgutter_git_executable == "yadm"
      let g:gitgutter_git_executable='git'
      echo "yadm: reset gitgutter executable path"
    endif
  endif
endfunction


if executable('yadm')
  autocmd BufReadPost * call YadmCheckGitFile()
endif
