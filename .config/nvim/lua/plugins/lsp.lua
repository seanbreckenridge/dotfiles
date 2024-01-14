return {
    'neovim/nvim-lspconfig',
    event = {"BufReadPre", "BufNewFile"},
    cmd = {"LspInfo", "LspInstall", "LspUninstall"},
    dependencies = {"hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp"},
    config = function()
        -- https://github.com/hrsh7th/cmp-nvim-lsp
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities =
            require("cmp_nvim_lsp").default_capabilities(capabilities)

        capabilities.textDocument.completion.completionItem.snippetSupport =
            true
        capabilities.workspace = {
            didChangeWatchedFiles = {
                -- https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
                -- https://github.com/neovim/neovim/issues/23291
                -- disable watchfiles for lsp, runs slow on linux
                dynamicRegistration = false
            }
        }

        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        local lspconf = require("lspconfig")

        -- web stuff
        lspconf.jsonls.setup {capabilities = capabilities}
        lspconf.cssls.setup {capabilities = capabilities}
        lspconf.html.setup {capabilities = capabilities}
        lspconf.eslint.setup {capabilities = capabilities}
        lspconf.cssmodules_ls.setup {capabilities = capabilities}
        lspconf.tailwindcss.setup {capabilities = capabilities}
        lspconf.tsserver.setup {capabilities = capabilities}
        lspconf.prismals.setup {capabilities = capabilities}
        lspconf.astro.setup {capabilities = capabilities}

        -- python
        -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md
        lspconf.pyright.setup {
            capabilities = capabilities,
            flags = {debounce_text_changes = 100}
        }

        -- yaml
        lspconf.yamlls.setup {
            capabilities = capabilities,
            settings = {yaml = {keyOrdering = false}}
        }

        -- c/c++
        lspconf.clangd.setup {capabilities = capabilities}

        -- shell
        lspconf.bashls.setup {capabilities = capabilities}

        -- golang
        lspconf.gopls.setup {capabilities = capabilities}

        -- elixir
        local elixir_ls_bin = vim.fn.exepath("elixir-ls")
        if elixir_ls_bin ~= "" then
            lspconf.elixirls.setup {
                cmd = {elixir_ls_bin},
                capabilities = capabilities
            }
        end

        -- ocaml
        lspconf.ocamllsp.setup {capabilities = capabilities}

        -- rust
        lspconf.rust_analyzer.setup {capabilities = capabilities}

        -- lua
        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")

        lspconf.lua_ls.setup {
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = {version = "LuaJIT", path = runtime_path},
                    diagnostics = {globals = {"vim"}},
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                        -- disable prompts for luv/luassert
                        checkThirdParty = false
                    }
                }
            }
        }

        -- https://www.reddit.com/r/neovim/comments/w2exp5/comment/j1lbogi/?utm_source=share&utm_medium=web2x&context=3
        local copilot_on = true
        vim.api.nvim_create_user_command("CopilotToggle", function()
            if copilot_on then
                vim.cmd("Copilot disable")
                print("Copilot OFF")
            else
                vim.cmd("Copilot enable")
                print("Copilot ON")
            end
            copilot_on = not copilot_on
        end, {nargs = 0})
        vim.keymap.set("", "<M-\\>", ":CopilotToggle<CR>",
                       {noremap = true, silent = true})

        -- disable lsp diagnostics for .env files
        local lsp_grp = vim.api.nvim_create_augroup("lsp_disable",
                                                    {clear = true})
        vim.api.nvim_create_autocmd({"BufEnter", "BufNewFile"}, {
            group = lsp_grp,
            pattern = {".env", ".env.*"},
            callback = function() vim.diagnostic.disable(0) end
        })

        -- lsp bindings
        function ShowDocumentation()
            if vim.tbl_contains({'vim', 'help'}, vim.bo.filetype) then
                vim.cmd('h ' .. vim.fn.expand('<cword>'))
            else
                vim.lsp.buf.hover()
            end
        end

        local wk = require("which-key")

        -- lsp commands with leader prefix
        wk.register({
            T = {vim.lsp.buf.code_action, "lsp code action"},
            r = {vim.lsp.buf.rename, "lsp rename"}
        }, {prefix = "<leader>"})

        -- lsp commands in normal mode
        wk.register({
            [']w'] = {
                function()
                    vim.diagnostic.goto_next()
                    vim.api.nvim_feedkeys("zz", "n", false)
                end, "next diagnostic"
            },
            ['[w'] = {
                function()
                    vim.diagnostic.goto_prev()
                    vim.api.nvim_feedkeys("zz", "n", false)
                end, "prev diagnostic"
            },
            [']e'] = {
                function()
                    vim.diagnostic.goto_next({
                        severity = vim.diagnostic.severity.ERROR
                    })
                    vim.api.nvim_feedkeys("zz", "n", false)
                end, "next error"
            },
            ['[e'] = {
                function()
                    vim.diagnostic.goto_prev({
                        severity = vim.diagnostic.severity.ERROR
                    })
                    vim.api.nvim_feedkeys("zz", "n", false)
                end, "prev error"
            },
            gd = {vim.lsp.buf.definition, "goto definition"},
            gt = {vim.lsp.buf.type_definition, "goto type definition"},
            gr = {vim.lsp.buf.references, "goto references"},
            K = {ShowDocumentation, "show documentation"}
        })

    end
}
