return {
    "nvim-neorg/neorg",
    dependencies = {"luarocks.nvim"},
    lazy = false,
    version = "*",
    config = function()
        require('neorg').setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.summary"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {personal = "~/Documents/Notes/notebooks/"}
                    }
                }
            }
        })
    end
}
