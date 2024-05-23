local ls = require "luasnip"

-- shorthands
local snippet = ls.s
local f = ls.function_node

ls.add_snippets("all", {
    -- date -> Tue 16 Nov 2021 09:43:49 AM EST
    snippet({trig = "date"}, {
        f(function()
            return string.format(
                       string.gsub(vim.bo.commentstring, "%%s", " %%s"),
                       os.date())
        end, {})
    })
})
