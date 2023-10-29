return {
    'github/copilot.vim',
    event = "InsertEnter",
    tag = "v1.11.1",
    config = function()
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
    end
}
