local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.ssh_domains = {
		{
			name = "wsl.server",
			username = "phurinutw",
			remote_address = "localhost:2222",
			multiplexing = "None",
		},
	}
	config.default_domain = "wsl.server"
end

return module
