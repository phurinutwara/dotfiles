local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.window_background_opacity = 0.35
	config.macos_window_background_blur = 45
	config.enable_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = true
end

return module
