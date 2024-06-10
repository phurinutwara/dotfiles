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

-- NOTE: To make sshd auto startup
--       Copy sshd.vbs script to shell:startup dir in host window os
--       See more: https://gist.github.com/dentechy/de2be62b55cfd234681921d5a8b6be11

return module
