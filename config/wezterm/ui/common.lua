local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.color_scheme = "Catppuccin Mocha"
	config.front_end = "WebGpu"
	config.webgpu_power_preference = "HighPerformance"
	config.max_fps = 240
	config.enable_wayland = true

	config.window_decorations = "RESIZE" -- NOTE: 'INTEGRATED_BUTTONS|RESIZE' to add 3 window buttons
	config.window_padding = {
		left = "1cell",
		right = "0cell",
		top = "0.5cell",
		bottom = "0cell",
	}
end

return module
