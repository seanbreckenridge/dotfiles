local wk = require('which-key')

-- project/config mappings
-- seanbreckenridge (personal functions/plugins)
wk.register({
    -- can change this to a different prefix if something ever conflicts
    c = {
        name = "change files",
        e = {
            function()
                require("seanbreckenridge.telescope").edit_config()
            end, 'edit config'
        },
        g = {
            function()
                require("seanbreckenridge.telescope").grep_config()
            end, 'grep config'
        },
        r = {
            function()
                local repo_bases =
                    require("seanbreckenridge.telescope").repo_bases_cached()
                require('telescope').extensions.repo.list {
                    search_dirs = repo_bases
                }
            end, 'switch repo'
        },
        -- p = {'<cmd>:Telescope projects<CR>', 'switch projects'},
        -- mnemonic 'cd' binding
        d = {
            function()
                local filename = vim.fn.expand('%:p:h')
                local cmd = 'cd ' .. filename
                vim.cmd(cmd)
                vim.notify('cd ' .. filename)
            end, 'cd to curdir'
        }
    }
}, {prefix = '<leader>'})

wk.register({
    f = {
        name = "telescope",
        f = {
            function() require('telescope.builtin').find_files() end,
            'find files'
        },
        g = {function() require('telescope.builtin').live_grep() end, 'grep'},
        r = {
            function() require('telescope.builtin').lsp_references() end,
            'references'
        },
        b = {function() require('telescope.builtin').buffers() end, 'buffers'},
        H = {
            function()
                require('seanbreckenridge.telescope').grep_help()
            end, 'help'
        },
        q = {function() require('telescope.builtin').quickfix() end, 'quickfix'},
        l = {function() require('telescope.builtin').loclist() end, 'loclist'},
        p = {
            function() require('telescope.builtin').git_files() end, 'git files'
        },
        o = {
            function() require('telescope.builtin').oldfiles() end, 'old files'
        },
        c = {function() require('telescope.builtin').commands() end, 'commands'},
        s = {
            function() require('telescope.builtin').spell_suggest() end,
            'spell suggest'
        },
        m = {function() require('telescope.builtin').marks() end, 'marks'},
        M = {
            function() require('telescope.builtin').man_pages() end, 'man pages'
        },
        n = {
            function()
                require('telescope').extensions.notify.notify()
            end, 'notify'
        },
        h = {
            function() require('telescope.builtin').command_history() end,
            'command history'
        },
        k = {function() require('telescope.builtin').keymaps() end, 'keymaps'},
        d = {
            function() require('telescope.builtin').diagnostics() end,
            'diagnostics'
        },
        L = {
            function() require('telescope.builtin').reloader() end, 'reload lua'
        },
        [' '] = {function() require('telescope.builtin').resume() end, 'resume'}
    }
}, {prefix = '<leader>'})

return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            lazy = true
        }, {'cljoly/telescope-repo.nvim', lazy = true}
    },
    cmd = 'Telescope',
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        local tl = require('telescope')
        local actions = require('telescope.actions')
        local previewers = require('telescope.previewers')
        local trouble = require('trouble.providers.telescope')

        -- this is a no-op for now, just here in case I want to modify things
        -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#previewers
        local buffer_previewer = function(filepath, bufnr, opts)
            opts = opts or {}
            return previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end

        -- https://github.com/nvim-telescope/telescope.nvim#pickers
        tl.setup {
            defaults = {
                winblend = 20, -- transparency
                path_display = {'smart'},
                -- Default configuration for telescope goes here:
                -- config_key = value,
                mappings = {
                    i = {
                        -- esc to exit in insert mode, I never really use normal mode
                        -- just use <C-j> and <C-k> to move up/down, <C-q> to send to quickfix
                        ["<Esc>"] = actions.close,
                        -- fzf-like up/down (remember, can also switch to normal mode and use j/k)
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-x>"] = trouble.open_with_trouble
                    }
                },
                -- ignore some directory caches with lots of file results
                file_ignore_patterns = {
                    '/discogs_cache/', '/feed_giantbomb_cache/',
                    '/feed_tmdb_cache/'
                },
                results_title = false, -- don't show results title
                prompt_title = false, -- don't show prompt title
                file_previewer = previewers.vim_buffer_cat.new,
                buffer_previewer_maker = buffer_previewer,
                preview = {
                    check_mime_type = true, -- check mime type before opening previewer
                    filesize_limit = 2, -- limit previewer to files under 2MB
                    timeout = 500, -- timeout previewer after 500 ms
                    treesitter = true -- use treesitter when available
                }
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                find_files = {find_command = {"rg", "--files", "--follow"}}
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case" -- or "ignore_case" or "respect_case"
                },
                repo = {list = {fd_opts = {}, previewer = false}}
            }
        }

        tl.load_extension('fzf') -- native fzf
        tl.load_extension('repo')
        tl.load_extension('projects')
        tl.load_extension('notify')
    end
}
