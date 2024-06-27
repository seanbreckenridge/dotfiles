return {
    "folke/trouble.nvim",
    event = "VeryLazy",
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
        { "<leader>xq", "<Cmd>Trouble qflist toggle<CR>", desc = "quickfix list" },
    },
    config = function()
        -- TODO: try more commands here to figure out which ones I want:
        -- https://github.com/folke/trouble.nvim?tab=readme-ov-file#commands
        local trouble = require("trouble")
        trouble.setup({})

        local wk = require("which-key")

        wk.register({
            x = {
                name = "trouble",
                -- git diff file with gitsigns (opens in trouble if installed)
                D = {
                    function()
                        require("gitsigns").setqflist()
                    end,
                    "git diff",
                },
                t = { "<Cmd>TodoTrouble<CR>", "show todos" },
            },
        }, { prefix = "<leader>" })
    end,
}
