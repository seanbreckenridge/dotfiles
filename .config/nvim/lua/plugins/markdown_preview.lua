return {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    -- only load when a markdown file is opened
    ft = "markdown",
    config = function()
        -- leader p to preview
        local wk = require("which-key")

        wk.register({
            ["<leader>p"] = {"<cmd>MarkdownPreview<cr>", "preview markdown"}
        })
    end
}
