-- lsp bindings
vim.api.nvim_set_keymap('n', ']w', "<cmd>lua vim.diagnostic.goto_next()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', '[w', "<cmd>lua vim.diagnostic.goto_prev()<CR>",
                        {silent = true})

vim.api.nvim_set_keymap('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', 'gr', "<cmd>lua vim.lsp.buf.references()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', 'rn', "<cmd>lua vim.lsp.buf.rename()<CR>",
                        {silent = true})
vim.api.nvim_set_keymap('n', '<leader>T',
                        "<cmd>lua vim.lsp.buf.code_action()<CR>",
                        {silent = true})

function ShowDocumentation()
    if vim.tbl_contains({'vim', 'help'}, vim.bo.filetype) then
        vim.cmd('h ' .. vim.fn.expand('<cword>'))
    else
        vim.lsp.buf.hover()
    end
end

vim.api.nvim_set_keymap('n', 'K', ":call ShowDocumentation()<CR>",
                        {silent = true})

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
