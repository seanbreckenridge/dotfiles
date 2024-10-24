return {
    {
        "windwp/nvim-ts-autotag",
        lazy = true,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        cmd = { "TSUpdate", "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        event = { "BufRead", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        config = function()
            -- require("nvim-treesitter.parsers").get_parser_configs()["rifleconfig"] = {
            --     install_info = {
            --         -- url = "~/Repos/tree-sitter-rifleconfig",
            --         url = "https://github.com/purarue/tree-sitter-rifleconfig",
            --         files = { "src/parser.c" },
            --         requires_generate_from_grammar = false,
            --         branch = "main",
            --     },
            -- }

            require("nvim-treesitter.configs").setup({
                modules = {},
                ignore_install = {},
                sync_install = false,
                auto_install = true,
                ensure_installed = {
                    "astro",
                    "awk",
                    "bash",
                    "c",
                    "commonlisp",
                    "cpp",
                    "css",
                    "csv",
                    "dart",
                    "diff",
                    "dockerfile",
                    "eex",
                    "elixir",
                    "erlang",
                    "git_config",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "graphql",
                    "html",
                    "java",
                    "javascript",
                    "jq",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "perl",
                    "php",
                    "prisma",
                    "python",
                    "query",
                    "regex",
                    "ruby",
                    "rust",
                    "sql",
                    "todotxt",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                highlight = {
                    enable = true, -- false will disable the whole extension
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    -- if you have some text visually selected, can use these keymaps to expand/reduce the selection
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["co"] = "@comment.outer",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = { ["<leader>a"] = "@parameter.inner" },
                        swap_previous = { ["<leader>A"] = "@parameter.inner" },
                    },
                },
            })

            require("treesitter-context").setup({
                enable = true,
                max_lines = 10,
                multiline_threshold = 5,
            })

            require("nvim-ts-autotag").setup()

            vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
                group = vim.api.nvim_create_augroup("disable-ts-context", { clear = true }),
                callback = function(e)
                    local ft ---@type string
                    if e.event == "FileType" then
                        ft = e.match
                    else
                        ft = vim.bo.filetype
                    end
                    if ft == "markdown" then
                        require("treesitter-context").disable()
                    else
                        require("treesitter-context").enable()
                    end
                end,
                desc = "disable treesitter context for markdown files, re-enable it when attaching other buffers",
            })
        end,
    },
}
