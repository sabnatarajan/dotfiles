local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then config = wezterm.config_builder() end

-- Settings
config.color_scheme = "Gruvbox dark, hard (base16)"
config.font_size = 14.0
config.font = wezterm.font_with_fallback({
	"JetbrainsMono Nerd Font",
})
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 100000

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5
}

-- Tab bar
config.use_fancy_tab_bar = false
config.status_update_interval = 1000

-- Keys
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Send C-a when pressing C-a twice
	{ key = "a", mods = "LEADER", action = act.SendKey { key = "a", mods = "CTRL" } },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	{ 
		key = "k", mods = "CMD",    action = act.Multiple {
			act.ClearScrollback 'ScrollbackAndViewport',
			act.SendKey {key = "l", mods = "CTRL"},
		},
	},

	-- Pane keybindings
	{ key = "i", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
	{ key = "o", mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },

	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },

	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "s", mods = "LEADER", action = act.RotatePanes "Clockwise" },

	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

	-- Tab keybindings
	{ key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "t", mods = "LEADER", action = act.ShowTabNavigator },

	-- Lastly, workspace
	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },

}
-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 0, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1)
	})
end

config.key_tables = {
	resize_pane = {
		{ key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
		{ key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
		{ key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
		{ key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter",  action = "PopKeyTable" },
	}
}

return config

