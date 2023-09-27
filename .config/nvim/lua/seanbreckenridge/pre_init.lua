-- save if yadm is installed as a global
-- used to disable some plugins if yadm is not installed
vim.g.has_yadm = vim.fn.executable('yadm') == 1

-- https://github.com/seanbreckenridge/on_machine
vim.g.on_os = os.getenv('ON_OS') or 'unknown'

-- lazy.nvim/which-key wants a leader to be set before setting up mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
