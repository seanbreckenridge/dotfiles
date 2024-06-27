local wk = require("which-key")

wk.register({
    o = {
        name = "octo",
        i = { "<Cmd>Octo issue list<CR>", "list issues" },
        I = { "<Cmd>Octo issue list --mine<CR>", "list my issues" },
        c = { "<Cmd>Octo issue create<CR>", "create issue" },
        p = { "<Cmd>Octo pr list<CR>", "list pull requests" },
        P = { "<Cmd>Octo pr list --mine<CR>", "list my pull requests" },
        o = { "<Cmd>Octo<CR>", "octo" },
    },
}, { prefix = "<leader>" })

return {
    "pwntester/octo.nvim",
    keys = { "<leader>o" },
    cmd = "Octo",
    config = function()
        require("octo").setup({ enable_builtin = true })
    end,
}
