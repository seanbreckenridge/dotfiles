return {
    'mfussenegger/nvim-lint',
    event = 'BufRead',
    config = function()
        local codespell_enabled = not vim.g.on_android
        -- some custom wrapper commands that use my global config files
        require('lint.linters.flake8').cmd = 'flake8c'
        if codespell_enabled then
            require('lint.linters.codespell').cmd = 'codespell-conf'
        end

        -- would add mypy here, but doesn't work great with imports
        -- pyright is good enough at that and typically faster
        local lint = require('lint')

        lint.linters_by_ft = {python = {"flake8"}}

        -- run lint on save, or when lsp attaches
        vim.api.nvim_create_autocmd({"BufWritePost", "LspAttach"}, {
            callback = function()
                lint.try_lint()
                if codespell_enabled then
                    lint.try_lint('codespell')
                end
            end
        })
    end
}
