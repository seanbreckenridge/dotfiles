local lsp_grp = vim.api.nvim_create_augroup("lsp_disable", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
    group = lsp_grp,
    pattern = {".env", ".env.*"},
    callback = function() vim.diagnostic.disable(0) end
})
