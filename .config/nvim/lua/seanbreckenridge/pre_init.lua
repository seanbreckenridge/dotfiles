-- save if yadm is installed as a global
-- used to disable some plugins if yadm is not installed
vim.g.has_yadm = vim.fn.executable('yadm') == 1

-- https://github.com/seanbreckenridge/on_machine
vim.g.on_os = os.getenv('ON_OS') or 'unknown'

-- lazy.nvim/which-key wants a leader to be set before setting up mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable tab key for copilot
vim.g.copilot_no_tab_map = true

-- for which-key
vim.o.timeout = true
vim.o.timeoutlen = 300

-- for nvim-ts-treesitter-context
vim.opt.updatetime = 250 -- decrease update time

-- copilot node version config
vim.g.copilot_ignore_node_version = 1
local nv = "~/.asdf/installs/nodejs/18.18.0/bin/node"
-- if asdf node install exists, use it
if vim.fn.filereadable(vim.fn.expand(nv)) == 1 then
    vim.g.copilot_node_command = nv
else
    vim.g.copilot_node_command = "node"
end
