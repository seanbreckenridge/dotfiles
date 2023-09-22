return {
    "mbbill/undotree",
    cmd = {"UndotreeToggle"},
    keys = {"<leader>u"},
    config = function()
        local wk = require("which-key")

        wk.register({["<leader>u"] = {"<cmd>UndotreeToggle<cr>", "undotree"}})
    end
}
