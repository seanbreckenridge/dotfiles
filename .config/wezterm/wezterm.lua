local wezterm = require 'wezterm'
local config = {}

config.color_scheme = "Dracula"
config.font = wezterm.font("Source Code Pro")
config.font_size = 14.0

config.keys = {
	{key="c", mods="CTRL|SHIFT", action=wezterm.action{CopyTo="Clipboard"}},
	{key="v", mods="CTRL|SHIFT", action=wezterm.action{PasteFrom="Clipboard"}},
}

-- create a resize mode, follow on at
-- https://wezfurlong.org/wezterm/config/key-tables.html

return config
