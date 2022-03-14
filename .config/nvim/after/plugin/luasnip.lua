local ls = require "luasnip"
-- local types = require "luasnip.util.types"

ls.config.set_config {
    history = true,
    -- support snippets that change dynamically
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true
}

-- shorthands
local snippet = ls.s
local f = ls.function_node
-- local t = ls.text_node

ls.snippets = {
    all = {
        -- date -> Tue 16 Nov 2021 09:43:49 AM EST
        snippet({trig = "date"}, {
            f(function()
                return string.format(string.gsub(vim.bo.commentstring, "%%s",
                                                 " %%s"), os.date())
            end, {})
        })
    }
}

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({"i", "s"}, "<c-k>", function()
    if ls.expand_or_jumpable() then ls.expand_or_jump() end
end, {silent = true})

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({"i", "s"}, "<c-j>",
               function() if ls.jumpable(-1) then ls.jump(-1) end end,
               {silent = true})

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes
vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then ls.change_choice(1) end
end)

-- shortcut to source my luasnips file again, which will reload my snippets
vim.keymap.set("n", "<leader>S",
               "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

-- Extend snippets
ls.filetype_extend("html", {})
ls.filetype_extend("shell", {})
ls.filetype_extend("gitcommit", {})
ls.filetype_extend("markdown", {})
ls.filetype_extend("go", {})
ls.filetype_extend("go", {})
ls.filetype_extend("css", {})
ls.filetype_extend("python", {})
ls.filetype_extend("javascript", {})
ls.filetype_extend("typescript", {})

require("luasnip.loaders.from_vscode").lazy_load()
