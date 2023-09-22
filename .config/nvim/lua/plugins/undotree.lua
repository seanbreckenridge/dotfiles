local wk = require("which-key")

wk.register({["<leader>u"] = {"<cmd>UndotreeToggle<cr>", "undotree"}})

return {"mbbill/undotree", cmd = {"UndotreeToggle"}, keys = {"<leader>u"}}
