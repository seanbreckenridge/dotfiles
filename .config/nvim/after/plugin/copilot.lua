-- disable copilot for .env files
local copilot_grp = vim.api.nvim_create_augroup("copilot", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
    group = copilot_grp,
    pattern = {".env", ".env.*"},
    callback = function(_) vim.b['copilot_enabled'] = 0 end
})

