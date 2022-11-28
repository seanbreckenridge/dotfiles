augroup bgproc_filetypes
  autocmd!
  " add filetype detection for bgproc - https://github.com/seanbreckenridge/bgproc
  autocmd! BufRead,BufNewFile *.job,*.job.disabled set filetype=bash
augroup END
