local wezterm = require 'wezterm'
local act = wezterm.action

-- <A-d>: 下にTerminal分割
-- <A-r>: 右にTerminal分割

-- <A-h>: ウィンドウ左移動
-- <A-j>: ウィンドウ下移動
-- <A-k>: ウィンドウ上移動
-- <A-l>: ウィンドウ右移動

return {
	{ key = 'd', mods = 'ALT', action = act.SplitVertical{ domain =  'CurrentPaneDomain' } },
	{ key = 'r', mods = 'ALT', action = act.SplitHorizontal{ domain =  'CurrentPaneDomain' } },
	{ key = 'w', mods = 'ALT', action = act.CloseCurrentPane{ confirm = false } },
	{ key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
	{ key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
	{ key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
	{ key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
}
