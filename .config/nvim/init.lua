-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- some config before loading plugins, to control how they load
require 'seanbreckenridge.pre_init'

-- load plugins from the 'lua/plugins' directory
require('lazy').setup('plugins', {
    browser = 'openurl',
    change_detection = {enabled = false, notify = false}
})

-- load my lua options/mappings
require 'seanbreckenridge'
