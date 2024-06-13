local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.color_scheme = "Catppuccin Frappe"
	config.front_end = "WebGpu"
	config.max_fps = 240
	config.window_decorations = "RESIZE" -- NOTE: 'INTEGRATED_BUTTONS|RESIZE' to add 3 window buttons
	config.window_padding = {
		left = "1cell",
		right = "0cell",
		top = "0.5cell",
		bottom = "0.5cell",
	}
end

return module
