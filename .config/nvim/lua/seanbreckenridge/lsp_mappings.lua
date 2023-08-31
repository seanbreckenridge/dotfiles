-- lsp bindings
local wk = require('which-key')

function ShowDocumentation()
    if vim.tbl_contains({'vim', 'help'}, vim.bo.filetype) then
        vim.cmd('h ' .. vim.fn.expand('<cword>'))
    else
        vim.lsp.buf.hover()
    end
end

-- lsp commands with leader prefix
wk.register({
    T = {vim.lsp.buf.code_action, "lsp code action"},
    r = {vim.lsp.buf.rename, "lsp rename"}
}, {prefix = "<leader>"})

-- lsp commands in normal mode
wk.register({
    [']w'] = {vim.diagnostic.goto_next, "next diagnostic"},
    ['[w'] = {vim.diagnostic.goto_prev, "prev diagnostic"},
    gd = {vim.lsp.buf.definition, "goto definition"},
    gr = {vim.lsp.buf.references, "goto references"},
    K = {ShowDocumentation, "show documentation"}
})

-- diagnostics
vim.cmd([[
augroup seanbreckenridge_lsp
  autocmd!
  autocmd! BufWrite,BufEnter,InsertLeave * lua vim.diagnostic.setloclist({open=false, severity = {min=vim.diagnostic.severity.HINT}})
augroup END
]])

-- copilot
vim.cmd([[
" copilot
" remove tab mapping -- map to alt+c
" to swap between choices, use alt+] and alt+[
imap <silent><script><expr> <M-c> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

let g:copilot_filetypes = {'*': v:true ,
  \ 'help': v:false,
  \ }
  ]])
