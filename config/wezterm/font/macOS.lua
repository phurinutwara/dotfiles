local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono", weight = "Regular", stretch = "Normal" },
		{ family = "Symbols Nerd Font Mono", scale = 0.75 },
		{ family = "Ayuthaya", scale = 1.0 },
	})
	config.font_size = 15.0
end

return module
