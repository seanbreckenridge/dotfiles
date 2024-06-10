-- the default 'gc' (:help commenting) binding works for most things, but react/web frameworks
-- have a different comment syntax, so this plugin only loads on those filetypes
return {
    "numToStr/Comment.nvim",
    ft = {
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
        "typescriptreact",
    },
    lazy = not vim.g.on_android, -- only load if on android, on an old version of nvim
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
        require("ts_context_commentstring").setup({ enable_autocmd = false })
        require("Comment").setup({
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        })
    end,
}
