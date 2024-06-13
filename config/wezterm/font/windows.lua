local wezterm = require("wezterm")

local module = {}

-- NOTE: To fix thai font ambiguous double width on WSL
-- 1. Use 'Courier MonoThai' font
-- 2. Bypass ConPTY by using `wezterm ssh` directly to wsl
--    (See more: https://github.com/wez/wezterm/issues/3704#issuecomment-1542533272 )
--    (And more: https://wezfurlong.org/wezterm/what-is-a-terminal.html#windows-and-conpty)
--
-- references:
-- 1. https://github.com/wez/wezterm/issues/3704
-- 2. setting up ssh: https://jmmv.dev/2022/02/wsl-ssh-access.html
-- 3. wezTerm ssh config: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
-- 4. nerdfonts download link: https://www.nerdfonts.com/font-downloads

function module.apply_to_config(config)
	config.treat_east_asian_ambiguous_width_as_wide = false
	config.font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono", weight = "Regular", stretch = "Normal" },
		{ family = "Symbols Nerd Font Mono", scale = 0.75 },
		{ family = "Courier MonoThai", scale = 1.10 },
	})
	config.font_size = 12.0
end

return module
