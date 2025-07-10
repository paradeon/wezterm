local wezterm = require("wezterm")

local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

local is_darwin = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

local is_windows = function()
	return wezterm.target_triple:find("windows") ~= nil
end

local mux = wezterm.mux
local act = wezterm.action

wezterm.on("git-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	{
		key = "a",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "i",
		mods = "LEADER",
		action = act.ActivateLastTab,
	},
	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},
}

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
if is_windows() then
	config.font_size = 9
else
	config.font_size = 12
end

-- config.font = wezterm.font 'Fira Code'
config.font = wezterm.font("JetBrains Mono")
config.color_scheme = "AfterGlow"
-- config.color_scheme = 'AdventureTime'

config.use_dead_keys = false

-- config.default_prog = {'/bin/zsh', '-l'}
config.window_decorations = "RESIZE"
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

-- Finally, return the configuration to wezterm:
return config

-- return {
--   default_prog = {'/bin/zsh', '-l'}
--   window_decorations = "RESIZE"
--   inactive_pane_hsb = {
--     saturation = 0.8
--     brightness = 0.7
--   }
-- }
