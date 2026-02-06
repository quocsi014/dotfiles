local wezterm = require("wezterm")
local os = require("os")

local config = wezterm.config_builder()

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 1

-- image setting
local user_home = os.getenv("HOME")
local background_folder = user_home .. "/.config/bg"
local current_background_image = background_folder .. "/hinata.jpg"
config.window_background_image = nil
config.window_background_image_hsb = {
	-- hue = 1.0,
	-- saturation = 4,
	-- brightness = 0.2,
	hue = 1.0,
	saturation = 1,
	brightness = 0.08,
}

config.window_padding = {
	left = 0,
	right = 0,
	bottom = 0,
	top = 0,
}
config.font_size = 14
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.color_scheme = "Tokyo Night Storm"
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)
--key map
config.keys = {
	{
		key = "b",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window)
			local overrides = window:get_config_overrides() or {}
			if not overrides.window_background_image then
				overrides.window_background_image = current_background_image
			else
				overrides.window_background_image = nil
			end
			window:set_config_overrides(overrides)
		end),
	},
}
return config
