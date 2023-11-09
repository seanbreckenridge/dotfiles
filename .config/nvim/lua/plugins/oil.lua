local has_trash_put = vim.fn.executable("trash-put") == 1

return {
    "stevearc/oil.nvim",
    opts = {
        default_file_explorer = true,
        columns = {"icon"},
        delete_to_trash = has_trash_put,
        trash_command = "trash-put"
    }
}
