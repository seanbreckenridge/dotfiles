local flake8 = require 'lint.linters.flake8'
flake8.cmd = 'flake8c'

require'lint'.linters_by_ft = {python = {"mypy", "flake8"}}
