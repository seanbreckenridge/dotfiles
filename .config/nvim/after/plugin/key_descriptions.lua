--- Adds descriptions to which-key's popup interface
--- to help describe the commands for vim plugins
--- which just show the command/function name
local wk = require("which-key")

-- https://github.com/machakann/vim-sandwich
wk.register({
    ["sa"] = "sandwich add",
    ["sd"] = "sandwich delete",
    ["sdb"] = "auto",
    ["sr"] = "sandwich replace",
    ["srb"] = "auto",
}, { mode = { "v", "n", "x" } })

-- https://github.com/seanbreckenridge/vim-unimpaired-conversions
local visualMaps = {
    ["[u"] = "url encode",
    ["[x"] = "xml encode",
    ["[y"] = "c-string encode",
    ["[C"] = "c-string-encode",
    ["]u"] = "url decode",
    ["]x"] = "xml decode",
    ["]y"] = "c-string decode",
    ["]C"] = "c-string-decode",
}
wk.register(visualMaps, { mode = "v" })

local normalMaps = vim.tbl_extend("keep", visualMaps, {
    ["[uu"] = "url encode line",
    ["[xx"] = "xml encode line",
    ["[yy"] = "c-string encode line",
    ["[CC"] = "c-string-encode line",
    ["]uu"] = "url decode line",
    ["]xx"] = "xml decode line",
    ["]yy"] = "c-string decode line",
    ["]CC"] = "c-string-decode line",
})
wk.register(normalMaps, { mode = "n" })
