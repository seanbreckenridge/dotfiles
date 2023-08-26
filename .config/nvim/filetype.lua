-- hmm I cant get this working
-- vim.filetype.add {pattern = {[".*/.*%.job$"] = "sh"}}
-- use autocmd for now...
local ft_grp = vim.api.nvim_create_augroup("filetype_cmds", {clear = true})
vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
    group = ft_grp,
    pattern = {"*.job", "*.job.disabled"},
    callback = function(_) vim.cmd("set filetype=sh") end
})
