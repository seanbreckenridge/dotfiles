return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/nvim-treesitter-textobjects',
        'JoosepAlviste/nvim-ts-context-commentstring', 'windwp/nvim-ts-autotag'
    },
    build = ':TSUpdate',
    config = function()
        require'nvim-treesitter.configs'.setup {
            modules = {},
            ignore_install = {},
            sync_install = false,
            auto_install = true,
            ensure_installed = {
                "bash", "cpp", "css", "html", "lua", "perl", "python", "rust",
                "go", "javascript", "json", "regex", "toml", "yaml", "vim",
                "todotxt", "typescript", "tsx", "c", "java", "php", "ruby",
                "dart", "elixir", "query", "prisma"
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
                        ['ic'] = '@class.inner'
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
            },
            context_commentstring = {enable = true},
            autotag = {
                enable = true,
                -- disable for tsx/more complex stuff till https://github.com/windwp/nvim-ts-autotag/issues/125
                filetypes = {'html', 'javascript', 'typescript'}
            }
        }
    end
}
