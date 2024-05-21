-- g? : show help
return {
    "stevearc/oil.nvim",
    keys = "<leader>e",
    cmd = "Oil",
    opts = {
        default_file_explorer = true,
        columns = {"icon"},
        delete_to_trash = true
    }
}
