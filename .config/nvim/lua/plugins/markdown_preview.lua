return {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    -- only load when filetype is markdown
    ft = "markdown",
    config = function()
        local wk = require("which-key")
        -- load plugin file so MarkdownPreview can be called

        wk.register({["p"] = {"<cmd>MarkdownPreview<cr>", "preview markdown"}},
                    {prefix = "<leader>"})
    end
}
