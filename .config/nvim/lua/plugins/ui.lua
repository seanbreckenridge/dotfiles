local wk = require("which-key")

wk.register({
    e = {function() require('oil').open() end, 'file explorer'},
    p = {"<cmd>MarkdownPreview<cr>", "preview markdown"},
    u = {"<cmd>UndotreeToggle<cr>", "undotree"}
}, {prefix = "<leader>"})

return {
    {"mbbill/undotree", cmd = {"UndotreeToggle"}, keys = {"<leader>u"}}, {
        'folke/zen-mode.nvim',
        dependencies = {'folke/twilight.nvim'},
        cmd = "ZenMode",
        opts = {}
    }, {
        "catppuccin/nvim",
        name = "catppuccin",
        -- colorscheme, 1000 makes things load early
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                background = {light = "latte", dark = "macchiato"},
                -- change background colors to match terminal
                color_overrides = {
                    macchiato = {base = "#282828"},
                    latte = {base = "#fbf1c7"}
                }
            })
            vim.cmd.colorscheme 'catppuccin'
        end
    }, {
        'nvim-lualine/lualine.nvim',
        priority = 1000,
        dependencies = {'nvim-tree/nvim-web-devicons'},
        opts = {options = {theme = 'catppuccin'}}
    }, {'j-hui/fidget.nvim', event = "LspAttach", opts = {}},
    {'stevearc/dressing.nvim', opts = {}, event = "VeryLazy"}, {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function() vim.notify = require("notify") end
    }, {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = {"nvim-lua/plenary.nvim"},
        opts = {}
    }, {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        ft = "markdown"
    }, {
        -- g? : show help
        "stevearc/oil.nvim",
        event = "VeryLazy",
        -- hmm.. doesn't seem to work when trying to trigger multiple times
        -- keys = "<leader>e",
        -- cmd = "Oil",
        opts = {
            default_file_explorer = true,
            columns = {"icon"},
            delete_to_trash = true
        }
    }, {
        '2kabhishek/nerdy.nvim',
        dependencies = {
            'stevearc/dressing.nvim', 'nvim-telescope/telescope.nvim'
        },
        cmd = 'Nerdy'
    }
}
