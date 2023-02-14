-- Colorscheme using https://github.com/catppuccin/nvim
-- for whatever reason, every theme I try with kitty (terminal emulator)
-- ends up having issues with the background/text combination, but
-- using a colorscheme from nvim instead of relying on the default
-- seems to fix that
local M = {}
-- match nvim theme to terminal theme
function M.load_current_theme()
    -- read from ~/.cache/kitty-theme-name if it exists
    -- set in https://sean.fish/d/kitty-set-theme?dark
    local kitty_theme_file = io.open(os.getenv("HOME") ..
                                         "/.cache/kitty-theme-name", "r")
    if kitty_theme_file ~= nil then
        local kitty_theme = kitty_theme_file:read()
        kitty_theme_file:close()
        if kitty_theme == "Dark" then
            return "dark"
        elseif kitty_theme == "Light" then
            return "light"
        end
    end
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
            macchiato = {
                -- https://sean.fish/d/Dark.conf?dark
                base = "#282828"
            },
            latte = {
                -- https://sean.fish/d/Light.conf?dark
                base = "#fbf1c7"
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
end

M.setup_theme = function()
    -- set the theme based on the current kitty theme
    M.terminal_theme = M.load_current_theme()
    vim.cmd("set background=" .. M.terminal_theme)
    M.setup_catppuccin()
    vim.cmd.colorscheme 'catppuccin'
end

M.setup_theme()

-- setup https://github.com/norcalli/nvim-colorizer.lua
require'colorizer'.setup({
    '*', -- Highlight all files, but customize some others.
    css = {rgb_fn = true}, -- Enable parsing rgb(...) functions in css.
    html = {names = false} -- Disable parsing "names" like Blue or Gray
})

return M
