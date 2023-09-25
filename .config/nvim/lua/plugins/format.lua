local wk = require("which-key")
wk.register({':Format<CR>', 'format'}, {prefix = '<leader>t'})

local cfg_format = function()
    local util = require('formatter.util')
    if util.get_current_buffer_file_name() == "setup.cfg" then
        return {
            exe = "setup-cfg-fmt-tempfile",
            stdin = true,
            args = {"--include-version-classifiers"}
        }
    else
        return nil
    end
end

return {
    'mhartington/formatter.nvim',
    -- hmm: using <leader>t as lazy load doesn't seem to work
    event = "VeryLazy",
    cmd = {'Format', 'FormatWrite', 'FormatLock', 'FormatWriteLock'},
    config = function()

        local fmt = require('formatter')
        -- local util = require('formatter.util')

        local prettier = require('formatter.defaults.prettier')
        local shfmt = require('formatter.filetypes.sh').shfmt
        local fixjson = require('formatter.filetypes.json').fixjson
        local clang = require('formatter.defaults.clangformat')
        local go = require('formatter.filetypes.go')

        -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
        fmt.setup {
            -- Enable or disable logging
            logging = true,
            -- Set the log level
            log_level = vim.log.levels.DEBUG,
            -- All formatter configurations are opt-in
            filetype = {
                html = prettier,
                json = fixjson,
                typescript = prettier,
                cfg = cfg_format,
                javascript = prettier,
                typescriptreact = prettier,
                javascriptreact = prettier,
                css = prettier,
                scss = prettier,
                markdown = prettier,
                yaml = prettier,
                toml = prettier,
                php = prettier,
                python = require('formatter.filetypes.python').black,
                lua = require('formatter.filetypes.lua').luaformat,
                rust = require('formatter.filetypes.rust').rustfmt,
                go = {go.goimports, go.gofmt},
                elixir = require('formatter.defaults.mixformat'),
                sh = shfmt,
                bash = shfmt,
                c = clang,
                cpp = clang,

                -- Use the special "*" filetype for defining formatter configurations on
                -- any filetype
                ["*"] = {
                    -- "formatter.filetypes.any" defines default configurations for any
                    -- filetype
                    {
                        require("formatter.filetypes.any").remove_trailing_whitespace
                    }
                }
            }
        }
    end
}
