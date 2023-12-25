local wezterm = require 'wezterm'
local config = {}

-- basic appearance
config.color_scheme = "Dracula"
config.font = wezterm.font("Source Code Pro")
config.font_size = 15.0
config.window_padding = {left = 0, right = 0, top = 0, bottom = 0}
config.hide_tab_bar_if_only_one_tab = true
config.colors = {background = "#282828"}

-- bell
config.visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 50,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 50,
    target = "CursorColor",
}
config.audible_bell = "Disabled"

-- scrollback
config.scrollback_lines = 10000

-- keybinds
config.keys = {
    -- clipboard
    {
        key = "c",
        mods = "SHIFT|ALT",
        action = wezterm.action {CopyTo = "Clipboard"}
    }, {
        key = "v",
        mods = "SHIFT|ALT",
        action = wezterm.action {PasteFrom = "Clipboard"}
    }, -- scrollback
    {
        key = "PageUp",
        mods = "SHIFT",
        action = wezterm.action {ScrollByPage = -1}
    },
    {
        key = "PageDown",
        mods = "SHIFT",
        action = wezterm.action {ScrollByPage = 1}
    }, -- create new tab
    {
        key = "t",
        mods = "SHIFT|ALT",
        action = wezterm.action {SpawnTab = "CurrentPaneDomain"}
    }, -- swap panes using vim keys
    {
        key = "j",
        mods = "SHIFT|ALT",
        action = wezterm.action {ActivatePaneDirection = "Down"}
    }, {
        key = "k",
        mods = "SHIFT|ALT",
        action = wezterm.action {ActivatePaneDirection = "Up"}
    }, {
        key = "h",
        mods = "SHIFT|ALT",
        action = wezterm.action {ActivatePaneDirection = "Left"}
    }, {
        key = "l",
        mods = "SHIFT|ALT",
        action = wezterm.action {ActivatePaneDirection = "Right"}
    }
}

return config
