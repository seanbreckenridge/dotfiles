local wk = require("which-key")

wk.add({ "<leader>x", group = "trouble" })

return {
    "folke/trouble.nvim",
    event = "VeryLazy",

    -- TODO: try more commands here to figure out which ones I want:
    -- https://github.com/folke/trouble.nvim?tab=readme-ov-file#commands
    keys = {
        {
            "<leader>xx",
            "<Cmd>Trouble diagnostics toggle<CR>",
            desc = "diagnostics",
        },
        {
            "<leader>xX",
            "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>",
            desc = "buffer diagnostics",
        },
        {
            "<leader>xl",
            "<Cmd>Trouble loclist toggle<CR>",
            desc = "location list",
        },
        { "<leader>xt", "<Cmd>TodoTrouble<CR>", desc = "show todos" },
        { "<leader>xq", "<Cmd>Trouble qflist toggle<CR>", desc = "quickfix list" },
        -- git diff file with gitsigns (opens in trouble if installed)
        {
            "<leader>xD",
            function()
                require("gitsigns").setqflist()
            end,
            desc = "git diff",
        },
    },
    opts = {},
}
