local wezterm = require "wezterm"

local config = wezterm.config_builder()

-- 描画形式
config.front_end = "WebGpu"

----------------------------------------------------------
-- Title Setting
----------------------------------------------------------

-- タイトルを非表示
config.window_decorations = "RESIZE"

-- タイトルの文字を変更
-- wezterm.on("format-window-title", function()
--     return "WezTerm"
-- end)

----------------------------------------------------------
-- Theme Setting
----------------------------------------------------------

-- テーマをNordに設定
config.color_scheme = 'nord'

----------------------------------------------------------
-- Window Setting
----------------------------------------------------------

-- ウィンドウ枠と余白（パディング）を消してNeovimと一体化
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }

-- 起動時にウィンドウを最大化する
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- 背景の不透明度（0.0 で完全透明、1.0 で不透明）
-- config.window_background_opacity = 0.85

-- Windowsのアクリル（すりガラス）効果を有効化
-- config.win32_system_backdrop = 'Acrylic' -- 'Acrylic', 'Mica', 'Tabbed', 'Disabled' も選べる

----------------------------------------------------------
-- Tab Setting
----------------------------------------------------------

-- タブを無効化
config.enable_tab_bar = false

----------------------------------------------------------
-- Font Setting
----------------------------------------------------------

config.font = wezterm.font_with_fallback({
    'Cica',
    'Symbols Nerd Font', -- アイコン欠けだけを補完するNerd公式フォント
})
config.font_size = 13.0
config.line_height = 1.1

----------------------------------------------------------
-- Shell Setting
----------------------------------------------------------

if wezterm.target_triple:find('windows') then
  config.default_prog = { 'C:\\Program Files\\Git\\bin\\bash.exe', '-l' }
elseif wezterm.target_triple:find('linux') then
  config.default_prog = { 'bash', '-l' }
end

----------------------------------------------------------
-- Other Setting
----------------------------------------------------------

-- keybindを有効化
config.keys = require "keybind"

return config
