return {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "onsails/lspkind.nvim",
        "hrsh7th/cmp-nvim-lua", "saadparwaiz1/cmp_luasnip",
        "petertriho/cmp-git", "nvim-lua/plenary.nvim", "hrsh7th/cmp-emoji"
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        lspkind.init()
        cmp.setup({
            mapping = {
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(),
                                        {'i', 'c'}),
                ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(),
                                        {'i', 'c'}),
                ["<C-e>"] = cmp.mapping.close(),
                ["<c-y>"] = cmp.mapping(cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                }, {"i", "c"}),
                ["<C-Space>"] = cmp.mapping {
                    i = cmp.mapping.complete(),
                    c = function(_ --[[fallback]] )
                        if cmp.visible() then
                            if not cmp.confirm {select = true} then
                                return
                            end
                        else
                            cmp.complete()
                        end
                    end
                },
                ["<tab>"] = cmp.config.disable
            },
            -- order ranks priority in completion drop-down -- higher has more priority
            sources = {
                {name = "nvim_lsp"}, -- update neovim lsp capabilities https://github.com/hrsh7th/cmp-nvim-lsp
                {name = "nvim_lua", keyword_length = 2}, -- lua completion for nvim-specific stuff
                {name = "git"}, -- cmp_git
                {name = "luasnip", keyword_length = 2}, -- snippets
                {name = "emoji", keyword_length = 3}, -- emoji
                {name = "path"}, -- complete names of files
                {name = "buffer", keyword_length = 4}
            },
            experimental = {native_menu = false, ghost_text = true},
            formatting = {
                format = lspkind.cmp_format {
                    with_text = true,
                    menu = {
                        buffer = "[buf]",
                        nvim_lsp = "[lsp]",
                        nvim_lua = "[lua]",
                        path = "[path]",
                        luasnip = "[snip]",
                        emoji = "[emoji]"
                    }
                }
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            }
        })

        local format = require("cmp_git.format")
        local sort = require("cmp_git.sort")

        require"cmp_git".setup({
            -- defaults
            filetypes = {"gitcommit", "octo"},
            remotes = {"upstream", "origin"}, -- in order of most to least prioritized
            enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
            git = {
                commits = {
                    limit = 100,
                    sort_by = sort.git.commits,
                    format = format.git.commits
                }
            },
            github = {
                hosts = {}, -- list of private instances of github
                issues = {
                    fields = {"title", "number", "body", "updatedAt", "state"},
                    filter = "all", -- assigned, created, mentioned, subscribed, all, repos
                    limit = 100,
                    state = "open", -- open, closed, all
                    sort_by = sort.github.issues,
                    format = format.github.issues
                },
                mentions = {
                    limit = 100,
                    sort_by = sort.github.mentions,
                    format = format.github.mentions
                },
                pull_requests = {
                    fields = {"title", "number", "body", "updatedAt", "state"},
                    limit = 100,
                    state = "open", -- open, closed, merged, all
                    sort_by = sort.github.pull_requests,
                    format = format.github.pull_requests
                }
            },
            gitlab = {
                hosts = {}, -- list of private instances of gitlab
                issues = {
                    limit = 100,
                    state = "opened", -- opened, closed, all
                    sort_by = sort.gitlab.issues,
                    format = format.gitlab.issues
                },
                mentions = {
                    limit = 100,
                    sort_by = sort.gitlab.mentions,
                    format = format.gitlab.mentions
                },
                merge_requests = {
                    limit = 100,
                    state = "opened", -- opened, closed, locked, merged
                    sort_by = sort.gitlab.merge_requests,
                    format = format.gitlab.merge_requests
                }
            },
            trigger_actions = {
                {
                    debug_name = "git_commits",
                    trigger_character = ":",
                    action = function(sources, trigger_char, callback, params,
                                      git_info)
                        return sources.git:get_commits(callback, params,
                                                       trigger_char)
                    end
                }, {
                    debug_name = "gitlab_issues",
                    trigger_character = "#",
                    action = function(sources, trigger_char, callback, params,
                                      git_info)
                        return sources.gitlab:get_issues(callback, git_info,
                                                         trigger_char)
                    end
                }, {
                    debug_name = "gitlab_mentions",
                    trigger_character = "@",
                    action = function(sources, trigger_char, callback, params,
                                      git_info)
                        return sources.gitlab:get_mentions(callback, git_info,
                                                           trigger_char)
                    end
                }, {
                    debug_name = "gitlab_mrs",
                    trigger_character = "!",
                    action = function(sources, trigger_char, callback, params,
                                      git_info)
                        return sources.gitlab:get_merge_requests(callback,
                                                                 git_info,
                                                                 trigger_char)
                    end
                }, {
                    debug_name = "github_issues_and_pr",
                    trigger_character = "#",
                    action = function(sources, trigger_char, callback, params,
                                      git_info)
                        return sources.github:get_issues_and_prs(callback,
                                                                 git_info,
                                                                 trigger_char)
                    end
                }, {
                    debug_name = "github_mentions",
                    trigger_character = "@",
                    action = function(sources, trigger_char, callback, params,
                                      git_info)
                        return sources.github:get_mentions(callback, git_info,
                                                           trigger_char)
                    end
                }
            }
        })
    end
}
