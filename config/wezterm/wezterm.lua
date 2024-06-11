-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
-- function os.capture(cmd, raw)
--   local f = assert(io.popen(cmd, 'r'))
--   local s = assert(f:read('*a'))
--   f:close()
--   if raw then return s end
--   s = string.gsub(s, '^%s+', '')
--   s = string.gsub(s, '%s+$', '')
--   s = string.gsub(s, '[\n\r]+', ' ')
--   return s
-- end
-- local os_type = os.capture('echo $(uname) | tr "[:upper:]" "[:lower:]"')

local common_font = require("font/common")
local common_ui = require("ui/common")

local font
local ui
local key = require("keymap")

local os_type = wezterm.target_triple
if string.match(os_type, "darwin*") then
	config.default_domain = "local"
	font = require("font/macOS")
	ui = require("ui/macOS")
else
	local wsl_ssh = require("ssh/wsl")
	wsl_ssh.apply_to_config(config)
	font = require("font/windows")
	ui = require("ui/windows")
end

common_font.apply_to_config(config)
common_ui.apply_to_config(config)
font.apply_to_config(config)
key.apply_to_config(config)
ui.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
