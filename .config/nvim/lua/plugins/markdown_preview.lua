return {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    ft = "markdown",
    config = function()
        local wk = require("which-key")
        wk.register({["p"] = {"<cmd>MarkdownPreview<cr>", "preview markdown"}},
                    {prefix = "<leader>"})
    end
}
