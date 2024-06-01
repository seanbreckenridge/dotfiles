return {
    {'folke/lazydev.nvim', ft = 'lua', cond = not vim.g.on_android}, -- update lua workspace libraries
    {'jceb/vim-orgmode', ft = 'org', dependencies = {"tpope/vim-speeddating"}}, -- orgmode
    {'jxnblk/vim-mdx-js', ft = 'mdx'} -- extended markdown
}
