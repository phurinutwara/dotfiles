local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.keys = {
		{
			key = "f",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ToggleFullScreen,
		},
	}

	config.mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	}
	config.bypass_mouse_reporting_modifiers = "SHIFT"
end

return module
