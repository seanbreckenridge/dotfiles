local M = {}
-- shorter helper w/ types to warn me for mapping keys
-- tried to use which-key but doesn't always work (e.g. for
-- incremental search and search/replace with selected text)

---@param key string the key to map
---@param cmd string|function the command to run
---@param desc string the description to show in which-key
---@param mode string|table the mode to map to, defaults to 'n'
M.map_key = function(key, cmd, desc, mode)
    vim.keymap
        .set(mode, key, cmd, {noremap = true, nowait = false, desc = desc})
end

---@param key string the key to map
---@param cmd string|function the command to run
---@param desc string the description to show in which-key
M.nnoremap = function(key, cmd, desc) M.map_key(key, cmd, desc, 'n') end

---@param key string the key to map
---@param cmd string|function the command to run
---@param desc string the description to show in which-key
M.vnoremap = function(key, cmd, desc) M.map_key(key, cmd, desc, 'v') end

return M
