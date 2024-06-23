local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.window_background_opacity = 0.35
	config.enable_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = false

	-- NOTE: Available options: Auto, Disable, Acrylic, Mica, Tabbed
	--       See more: https://wezfurlong.org/wezterm/tags.html#appearance
	config.win32_system_backdrop = "Tabbed"
end

return module
