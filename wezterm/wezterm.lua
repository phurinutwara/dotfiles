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
config.default_domain = 'WSL:Ubuntu-20.04'

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13.0

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.90
config.macos_window_background_blur = 30

config.window_decorations = 'RESIZE'
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

-- and finally, return the configuration to wezterm
return config
