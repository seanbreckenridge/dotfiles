return {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")

        wk.register({["<leader>u"] = {"<cmd>UndotreeToggle<cr>", "undotree"}})
    end
}
