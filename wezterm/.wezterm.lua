local wezterm = require 'wezterm'
local os = require("os")

local config = wezterm.config_builder()

config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- image setting
local user_home = os.getenv("HOME")
local background_folder = user_home .. "/.config/bg"
config.window_background_image = background_folder..'/6678293.jpg'
config.window_background_image_hsb = {
  hue = 1.0,
  saturation = 4,
  brightness = 0.2,
}

config.window_padding = {
  left = 0,
  right = 0,
  bottom = 0,
  top = 0,
}
config.font_size = 14
config.font =
  wezterm.font('JetBrains Mono', {
    weight = 'Medium',
  })
config.color_scheme = 'Tokyo Night Storm'
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
end)
return config
