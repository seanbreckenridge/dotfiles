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

-- some config before loading plugins, to control how they load
require 'seanbreckenridge.pre_init'

-- load plugins from the 'lua/plugins' directory
require'lazy'.setup 'plugins'

-- load my lua options/mappings/colorscheme
require 'seanbreckenridge'
