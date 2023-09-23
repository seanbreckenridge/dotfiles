-- Close help buffer with q
vim.keymap.set("n", "q", ":bd<cr>", {buffer = 0})
-- 'gd' to go to definition (Ctrl-])
vim.keymap.set("n", "gd", "<C-]>", {buffer = 0})
