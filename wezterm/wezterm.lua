-- Pull in the wezterm API
local wezterm = require 'wezterm'

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

local os_type = wezterm.target_triple
if (string.match(os_type, 'darwin*')) then
  config.default_domain = 'local'
  config.window_background_opacity = 0.35
  config.macos_window_background_blur = 45
  config.font = wezterm.font('JetBrains Mono', { weight = 'Bold', stretch = 'Normal' })
  config.font_size = 17.0
  config.enable_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = true
else
  config.default_domain = 'WSL:Ubuntu'
  config.window_background_opacity = 0.75
  config.win32_system_backdrop = 'Auto'
  config.font = wezterm.font_with_fallback {
    { family = 'JetBrains Mono', },
    { family = 'Sarabun' },
  }
  config.font_size = 13.0
  config.enable_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = false
end

config.color_scheme = 'Catppuccin Mocha'
config.max_fps = 240


config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_padding = {
  top = "1cell"
}
config.keys = {
  {
    key = 'f',
    mods = 'CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}

config.mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}
config.bypass_mouse_reporting_modifiers = 'SHIFT'

-- and finally, return the configuration to wezterm
return config
