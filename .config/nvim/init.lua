-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- save if yadm is installed as a global
vim.g.has_yadm = vim.fn.executable('yadm') == 1

-- setup leader for lazy
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- load plugins from the 'lua/plugins' directory
require'lazy'.setup 'plugins'

-- set filetype to on after plugins are loaded  to prevent possible errors
vim.cmd 'filetype plugin indent on'

-- load my lua options/colorscheme
require 'seanbreckenridge'
