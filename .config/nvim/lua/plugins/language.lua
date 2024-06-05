return {
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        cond = not vim.g.on_android,
        opts = {
            library = {
                -- Library items can be absolute paths
                -- "~/projects/my-awesome-lib",
                -- Or relative, which means they will be resolved as a plugin
                -- "LazyVim",
                -- When relative, you can also provide a path to the library in the plugin dir
                "luvit-meta/library" -- see below
            }
        }
    }, -- update lua workspace libraries
    {"Bilal2453/luvit-meta", lazy = true},
    {'jceb/vim-orgmode', ft = 'org', dependencies = {"tpope/vim-speeddating"}}, -- orgmode
    {'jxnblk/vim-mdx-js', ft = 'mdx'} -- extended markdown
}
