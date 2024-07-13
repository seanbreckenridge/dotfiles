local wk = require("which-key")

wk.add({ { "<leader>o", group = "octo" }, { "<leader>oi", group = "issue" }, { "<leader>op", group = "pr" } })

return {
    "pwntester/octo.nvim",
    keys = {
        {
            "<leader>oil",
            "<Cmd>Octo issue list<CR>",
            desc = "list issues",
        },
        {
            "<leader>oic",
            "<Cmd>Octo issue create<CR>",
            desc = "create issue",
        },
        {
            "<leader>opl",
            "<Cmd>Octo pr list<CR>",
            desc = "list pull requests",
        },
        {
            "<leader>opm",
            "<Cmd>Octo pr list --mine<CR>",
            desc = "list my pull requests",
        },
        {
            "<leader>oo",
            "<Cmd>Octo<CR>",
            desc = "octo",
        },
    },
    cmd = "Octo",
    config = function()
        require("octo").setup({ enable_builtin = true })
    end,
}
