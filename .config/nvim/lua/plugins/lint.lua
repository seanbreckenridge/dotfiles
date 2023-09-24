return {
    'mfussenegger/nvim-lint',
    event = 'BufRead',
    config = function()
        local flake8 = require 'lint.linters.flake8'
        flake8.cmd = 'flake8c'

        -- would add mypy here, but doesn't work great with imports
        -- pyright is good enough at that and typically faster

        require'lint'.linters_by_ft = {python = {"flake8"}}

        -- run lint on save, or when lsp attaches
        vim.api.nvim_create_autocmd({"BufWritePost", "LspAttach"}, {
            callback = function() require("lint").try_lint() end
        })
    end
}
