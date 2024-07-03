-- the default 'gc' (:help commenting) binding works for most things, but react/web frameworks
-- have a different comment syntax, so this plugin only loads on those filetypes
return {
    { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
    {
        "numToStr/Comment.nvim",
        ft = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
        },
        keys = { { "gc", mode = { "n", "v" } }, { "gbc", mode = { "n", "v" } } },
        lazy = not vim.g.on_android, -- only load if on android, on an old version of nvim
        config = function()
            require("ts_context_commentstring").setup({ enable_autocmd = false })
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },
}
