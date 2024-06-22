local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.window_background_opacity = 0
	config.win32_system_backdrop = "Acrylic"
	config.enable_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = false
end

return module
