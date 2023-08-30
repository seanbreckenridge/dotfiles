-- check spelling when writing a git commit
vim.cmd [[
augroup seanbreckenridge_spelling
    autocmd!
    autocmd! BufRead,BufNewFile gitcommit | set spell
augroup END]]
