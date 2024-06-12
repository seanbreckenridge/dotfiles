return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        cond = not vim.g.on_android,
        opts = {
            library = {
                -- Library items can be absolute paths
                -- "~/projects/my-awesome-lib",
                -- Or relative, which means they will be resolved as a plugin
                -- "LazyVim",
                -- When relative, you can also provide a path to the library in the plugin dir
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    }, -- update lua workspace libraries
    { "Bilal2453/luvit-meta", lazy = true },
    { "tpope/vim-sleuth", event = "VeryLazy" }, -- detect indentation
    {
        "seanbreckenridge/tree-sitter-rifleconfig",
        ft = "rifleconfig",
        -- dir = '~/Repos/tree-sitter-rifleconfig'
    },
}
