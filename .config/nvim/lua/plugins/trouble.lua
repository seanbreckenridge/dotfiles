return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons"},
    config = function()
        local trouble = require("trouble")
        trouble.setup {}

        local wk = require("which-key")

        wk.register({
            x = {
                name = "trouble",
                -- git diff file with gitsigns (opens in trouble if installed)
                D = {
                    function()
                        require("gitsigns").setqflist()
                    end, "git diff"
                },
                x = {
                    function() require("trouble").toggle() end, "toggle trouble"
                },
                w = {
                    function()
                        require("trouble").toggle("workspace_diagnostics")
                    end, "toggle workspace"
                },
                d = {
                    function()
                        require("trouble").toggle("document_diagnostics")
                    end, "toggle document"
                },
                q = {
                    function()
                        require("trouble").toggle("quickfix")
                    end, "toggle quickfix"
                },
                l = {
                    function()
                        require("trouble").toggle("loclist")
                    end, "toggle loclist"
                },
                r = {
                    function()
                        require("trouble").toggle("lsp_references")
                    end, "toggle lsp references"
                },
                t = {'<Cmd>:TodoTrouble<CR>', "show todos"}
            }
        }, {prefix = "<leader>"})
    end
}
