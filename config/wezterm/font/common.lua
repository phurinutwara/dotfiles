local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.adjust_window_size_when_changing_font_size = false
end

return module
