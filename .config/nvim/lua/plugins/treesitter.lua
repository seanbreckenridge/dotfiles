return {
    'nvim-treesitter/nvim-treesitter',
    event = {"BufRead", "BufNewFile"},
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects', 'windwp/nvim-ts-autotag'
    },
    build = ':TSUpdate',
    config = function()
        -- Prefer git instead of curl in order to improve connectivity in some environments
        require('nvim-treesitter.install').prefer_git = true
        require('nvim-treesitter.configs').setup {
            modules = {},
            ignore_install = {},
            sync_install = false,
            auto_install = true,
            ensure_installed = {
                "astro", "awk", "bash", "c", "commonlisp", "cpp", "css", "csv",
                "dart", "diff", "dockerfile", "eex", "elixir", "erlang",
                "git_config", "gitcommit", "gitignore", "go", "graphql", "html",
                "java", "javascript", "jq", "json", "lua", "make", "perl",
                "php", "prisma", "python", "query", "regex", "ruby", "rust",
                "sql", "todotxt", "toml", "tsx", "typescript", "vim", "vimdoc",
                "yaml"
            },
            highlight = {
                enable = true -- false will disable the whole extension
            },
            indent = {enable = true},
            incremental_selection = {
                enable = true,
                -- if you have some text visually selected, can use these keymaps to expand/reduce the selection
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<c-backspace>'
                }
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['co'] = '@comment.outer'
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer'
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer'
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer'
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer'
                    }
                },
                swap = {
                    enable = true,
                    swap_next = {['<leader>a'] = '@parameter.inner'},
                    swap_previous = {['<leader>A'] = '@parameter.inner'}
                }
            }
        }

        require('nvim-ts-autotag').setup()

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {"markdown"},
            group = vim.api.nvim_create_augroup("disable-ts-context",
                                                {clear = true}),
            callback = function()
                require("treesitter-context").disable()
            end
        })
    end
}
