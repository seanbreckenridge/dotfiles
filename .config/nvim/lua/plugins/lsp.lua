return {
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        lazy = true,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        config = function()
            -- https://github.com/hrsh7th/cmp-nvim-lsp
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.workspace = {
                didChangeWatchedFiles = {
                    -- https://github.com/neovim/neovim/issues/23725#issuecomment-1561364086
                    -- https://github.com/neovim/neovim/issues/23291
                    -- disable watchfiles for lsp, runs slow on linux
                    dynamicRegistration = false,
                },
            }

            -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
            local lspconf = require("lspconfig")
            -- lua config
            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

            local servers = {
                jsonls = {
                    settings = {
                        json = {
                            schemas = require("schemastore").json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },
                pyright = { flags = { debounce_text_changes = 100 } },
                yamlls = {
                    settings = {
                        yaml = {
                            keyOrdering = false,
                            schemaStore = {
                                -- Disable built-in schemaStore support
                                enable = false,
                                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                                url = "",
                            },
                            schemas = require("schemastore").yaml.schemas(),
                        },
                    },
                },
                bashls = true,
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT", path = runtime_path },
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = vim.api.nvim_get_runtime_file("", true),
                                -- disable prompts for luv/luassert
                                checkThirdParty = false,
                            },
                        },
                    },
                },
            }
            -- disable some LSPs on android
            if not vim.g.on_android then
                -- find elixir-ls binary
                local elixir_ls_bin = vim.fn.exepath("elixir-ls")
                if elixir_ls_bin ~= "" then
                    servers.elixirls = { cmd = { elixir_ls_bin } }
                end
                servers.clangd = true
                servers.gopls = true
                servers.ocamllsp = true
                servers.rust_analyzer = true
                servers.cssls = true
                servers.html = true
                servers.eslint = true
                servers.cssmodules_ls = true
                servers.tailwindcss = true
                servers.tsserver = true
                servers.prismals = true
                servers.astro = true
            end

            for server, config in pairs(servers) do
                if config == true then
                    -- vim.log.info("LSP config: " .. server ..
                    --                      vim.inspect({capabilities = capabilities}))
                    lspconf[server].setup({ capabilities = capabilities })
                else
                    local combined = vim.tbl_extend("force", { capabilities = capabilities }, config)
                    -- vim.log.info("LSP config: " .. server .. vim.inspect(combined))
                    lspconf[server].setup(combined)
                end
            end

            local lsp_grp = vim.api.nvim_create_augroup("lsp_disable", { clear = true })
            vim.api.nvim_create_autocmd({ "BufEnter", "BufNewFile" }, {
                group = lsp_grp,
                pattern = { ".env", ".env.*" },
                callback = function()
                    vim.diagnostic.enable(false)
                end,
                desc = "disable lsp diagnostics for .env files",
            })

            -- lsp bindings
            function ShowDocumentation()
                if vim.tbl_contains({ "vim", "help" }, vim.bo.filetype) then
                    vim.cmd("h " .. vim.fn.expand("<cword>"))
                else
                    vim.lsp.buf.hover()
                end
            end

            local wk = require("which-key")

            -- run on any client connecting
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
                ---@diagnostic disable-next-line: unused-local
                callback = function(event)
                    -- set omnifunc to lsp omnifunc
                    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
                    -- when the client attaches, add keybindings
                    -- lsp commands with leader prefix
                    wk.register({
                        T = { vim.lsp.buf.code_action, "lsp code action" },
                        r = { vim.lsp.buf.rename, "lsp rename" },
                    }, { prefix = "<leader>" })

                    -- lsp commands in normal mode
                    wk.register({
                        ["]w"] = {
                            function()
                                vim.diagnostic.jump({ count = 1 })
                                vim.api.nvim_feedkeys("zz", "n", false)
                            end,
                            "next diagnostic",
                        },
                        ["[w"] = {
                            function()
                                vim.diagnostic.jump({ count = -1 })
                                vim.api.nvim_feedkeys("zz", "n", false)
                            end,
                            "prev diagnostic",
                        },
                        ["]e"] = {
                            function()
                                vim.diagnostic.jump({
                                    count = 1,
                                    severity = vim.diagnostic.severity.ERROR,
                                })
                                vim.api.nvim_feedkeys("zz", "n", false)
                            end,
                            "next error",
                        },
                        ["[e"] = {
                            function()
                                vim.diagnostic.jump({
                                    count = -1,
                                    severity = vim.diagnostic.severity.ERROR,
                                })
                                vim.api.nvim_feedkeys("zz", "n", false)
                            end,
                            "prev error",
                        },
                        gd = { vim.lsp.buf.definition, "goto definition" },
                        gt = { vim.lsp.buf.type_definition, "goto type definition" },
                        gr = { vim.lsp.buf.references, "goto references" },
                        K = { ShowDocumentation, "show documentation" },
                        D = { vim.diagnostic.open_float, "diagnostic hover" },
                    })
                    -- BUG: hmm... doesn't actually seem to display for me
                    --
                    -- local client = vim.lsp.get_client_by_id(event.data.client_id)
                    -- if client and vim.lsp.inlay_hint and
                    --     client.supports_method('textDocument/inlayHint') then
                    --     wk.register({
                    --         ['ft'] = {
                    --             function()
                    --                 vim.lsp.inlay_hint.enable(
                    --                     not vim.lsp.inlay_hint.is_enabled({}))
                    --             end, "toggle inlay hints"
                    --         }
                    --     }, {prefix = "<leader>"})
                    --     -- toggle on by default, for now
                    --     vim.lsp.inlay_hint.enable(true)
                    -- end
                end,
                desc = "lsp keybindings",
            })
        end,
    },
}
