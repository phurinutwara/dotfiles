local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono" }, -- TODO: TO BE FIXED
		{ family = "Sarabun" }, -- TODO: TO BE FIXED
	})
	config.font_size = 16.0
end

return module
