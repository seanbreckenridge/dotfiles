-- Colorscheme using https://github.com/catppuccin/nvim
-- for whatever reason, every theme I try with kitty (terminal emulator)
-- ends up having issues with the background/text combination, but
-- using a colorscheme from nvim instead of relying on the default
-- seems to fix that
--
-- TODO: could check envvar set by kitty theme to set the background
--       to light/dark by checking some file in ~/.config/kitty/
--       see :h background
require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "macchiato"
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {enabled = false, shade = "dark", percentage = 0.05},
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = {"italic"},
        conditionals = {"italic"},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {}
    },
    color_overrides = {
        macchiato = {
            -- change background color to match terminal
            -- https://sean.fish/d/Dark.conf?dark
            base = "#282828"
        }
    },
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        markdown = true,
        notify = false,
        mini = false
    }
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
