local M = {}
function M.load_current_theme()
    return "dark" -- default to dark
end

M.setup_catppuccin = function()
    require("catppuccin").setup({
        flavour = M.terminal_theme == "dark" and "macchiato" or "latte",
        background = {light = "latte", dark = "macchiato"},
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
        -- change background colors to match terminal
        color_overrides = {
            macchiato = {base = "#282828"},
            latte = {base = "#fbf1c7"}
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
end

M.setup_theme = function()
    M.terminal_theme = M.load_current_theme()
    vim.cmd("set background=" .. M.terminal_theme)
    M.setup_catppuccin()
    vim.cmd.colorscheme 'catppuccin'
end

return M
