return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons"},
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "diagnostics"
        }, {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "buffer diagnostics"
        },
        {
            "<leader>xl",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "location list"
        },
        {"<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "quickfix list"}
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
                D = {function() require("gitsigns").setqflist() end, "git diff"},
                t = {"<Cmd>:TodoTrouble<CR>", "show todos"}
            }
        }, {prefix = "<leader>"})
    end
}
