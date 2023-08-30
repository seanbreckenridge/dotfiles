-- https://github.com/mfussenegger/nvim-lint
vim.api.nvim_create_autocmd({"BufWritePost"}, {
    callback = function() require("lint").try_lint() end
})

local flake8 = require 'lint.linters.flake8'
flake8.cmd = 'flake8c'

-- would add mypy here, but doesnt work great with imports
-- pylint is good enough at that and typically faster

require'lint'.linters_by_ft = {python = {"flake8"}}
