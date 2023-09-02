return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            lazy = true
        }, {'cljoly/telescope-repo.nvim', lazy = true}
    },
    event = "VeryLazy",
    cmd = 'Telescope',
    keys = {"<leader>f", "<leader>c", "<leader>g"},
    config = function()
        local tl = require('telescope')
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        local previewers = require('telescope.previewers')
        local trouble = require('trouble.providers.telescope')

        -- this is a no-op for now, just here incase I want to modify things
        -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#previewers
        local buffer_previewer = function(filepath, bufnr, opts)
            opts = opts or {}
            return previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end

        -- https://github.com/nvim-telescope/telescope.nvim#pickers
        tl.setup {
            defaults = {
                path_display = {'smart'},
                -- Default configuration for telescope goes here:
                -- config_key = value,
                mappings = {
                    i = {
                        -- fzf-like up/down (remember, can also switch to normal mode and use j/k)
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-t>"] = trouble.open_with_trouble
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

        tl.load_extension('fzf')
        tl.load_extension('repo')
        tl.load_extension('projects')
        -- to try:
        -- https://github.com/pwntester/octo.nvim

        -- setup mappings for telescope
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
                        tl.extensions.repo.list {search_dirs = repo_bases}
                    end, 'switch repo'
                },
                p = {'<cmd>:Telescope projects<CR>', 'switch projects'}
            }
        }, {prefix = '<leader>'})

        wk.register({
            f = {
                name = "telescope",
                f = {builtin.find_files, 'find files'},
                g = {builtin.live_grep, 'grep'},
                r = {builtin.lsp_references, 'references'},
                b = {builtin.buffers, 'buffers'},
                H = {
                    function()
                        require('seanbreckenridge.telescope').grep_help()
                    end, 'help'
                },
                q = {builtin.quickfix, 'quickfix'},
                l = {builtin.loclist, 'loclist'},
                p = {builtin.git_files, 'git files'},
                o = {builtin.oldfiles, 'old files'},
                t = {":TodoTrouble<CR>", 'todos'},
                c = {builtin.commands, 'commands'},
                s = {builtin.spell_suggest, 'spell suggest'},
                m = {builtin.marks, 'marks'},
                M = {builtin.man_pages, 'man pages'},
                h = {builtin.command_history, 'command history'},
                k = {builtin.keymaps, 'keymaps'},
                d = {builtin.diagnostics, 'diagnostics'},
                L = {builtin.reloader, 'reload lua'}
            }
        }, {prefix = '<leader>'})

    end
}
