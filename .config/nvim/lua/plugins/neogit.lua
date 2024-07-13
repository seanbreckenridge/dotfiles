local wk = require("which-key")

wk.add({ "<leader>g", group = "git" })

return {
    { "sindrets/diffview.nvim", cmd = "DiffviewOpen", config = true, lazy = true },
    {
        "NeogitOrg/neogit",
        config = true,
        cmd = "Neogit",
        keys = {
            {
                "<leader>gg",
                function()
                    require("neogit").open()
                end,
                desc = "console",
            },
            {
                "<leader>gp",
                function()
                    require("neogit").open({ "push" })
                end,
                desc = "push",
            },
            {
                "<leader>gl",
                function()
                    require("neogit").open({ "pull" })
                end,
                desc = "pull",
            },
            {
                "<leader>go",
                function()
                    require("neogit").open({ "log" })
                end,
                desc = "log",
            },
            {
                "<leader>gc",
                function()
                    require("neogit").open({ "commit" })
                end,
                desc = "commit",
            },
            {
                "<leader>gs",
                function()
                    require("neogit").open()
                end,
                desc = "status",
            },
            {
                "<leader>gd",
                function()
                    require("neogit").open({ "diff" })
                end,
                desc = "diff",
            },
            {
                "<leader>gb",
                function()
                    require("telescope.builtin").git_branches()
                end,
                desc = "telescope branch",
            },
        },
    },
}
