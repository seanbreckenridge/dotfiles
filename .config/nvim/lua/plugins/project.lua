return {
    "ahmedkhalf/project.nvim",
    lazy = true,
    config = function()
        require'project_nvim'.setup({
            -- All the patterns used to detect root dir, when **"pattern"** is in
            -- detection_methods
            patterns = {
                ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile",
                "package.json", "node_modules", "Cargo.toml", "go.mod",
                "setup.cfg", "setup.py"
            },

            -- Don't calculate root dir on specific directories
            -- Ex: { "~/.cargo/*", ... }
            exclude_dirs = {},

            -- When set to false, you will get a message when project.nvim changes your
            -- directory.
            silent_chdir = true
        })
    end
}
