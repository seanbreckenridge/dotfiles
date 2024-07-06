local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim/which-key wants a leader to be set before setting up mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- https://github.com/seanbreckenridge/on_machine
-- what operating system I'm on controls how some plugins load
vim.g.on_os = os.getenv("ON_OS") or "unknown" ---@type string
vim.g.on_android = vim.split(vim.g.on_os, "_")[1] == "android" ---@type boolean

-- load plugins from the 'lua/plugins' directory
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    browser = "openurl",
    change_detection = { enabled = false, notify = false },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- load my lua options/mappings
require("user")
