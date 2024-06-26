---create an autocmd group, clearing any existing commands
---test something  else here
---
---@param name string
local function clear_group(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "highlight when yanking (copying) text",
    callback = function()
        vim.highlight.on_yank()
    end,
    group = clear_group("YankHighlight"),
    pattern = "*",
})

local user_autocompile = clear_group("UserAutocompile")

vim.api.nvim_create_autocmd("BufWritePost", {
    command = "!reshortcuts",
    group = user_autocompile,
    pattern = { ".config/shortcuts.toml", "shortcuts.toml" },
    desc = "create shortcuts script when I save config file",
})

vim.api.nvim_create_autocmd("BufWritePost", {
    command = "!i3-jinja",
    group = user_autocompile,
    pattern = { ".config/i3/config.j2", "i3/config.j2" },
    desc = "create i3 config when I save config file",
})

vim.api.nvim_create_autocmd("BufWritePost", {
    command = "!rm -f $(evry location -i3blocks-cache)",
    group = user_autocompile,
    pattern = { ".config/i3blocks/config.*", "i3blocks/config.*" },
    desc = "clear i3blocks cache file when I save config",
})

vim.api.nvim_create_autocmd("TermOpen", {
    desc = "enter insert mode when I open a terminal",
    command = "startinsert",
    group = clear_group("TerminalInsert"),
    pattern = "*",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
    desc = "disable LLM-generation for .env files",
    group = clear_group("LlmGroup"),
    pattern = { ".env", ".env.*" },
    callback = function()
        vim.b["codeium_enabled"] = false
    end,
})
