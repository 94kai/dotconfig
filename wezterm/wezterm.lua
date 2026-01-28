-- 同级目录创建local-config.lua，内容如下
-- return {
-- 	api_url = "",
-- 	api_key = "",
-- 	model = "",
-- }

local wezterm = require("wezterm")
local ai_helper = require("ai-helper")
local act = wezterm.action

-- 加载本地配置（如果存在）
local local_config = {}
local ok, result = pcall(require, "local-config")
if ok then
	local_config = result
	wezterm.log_info("Loaded local.config")
else
	wezterm.log_info("local.config not found")
end

-- This will hold the configuration.
local config = wezterm.config_builder()
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE" -- macOS 不显示 title bar
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.disable_default_key_bindings = true
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1500 }

-- 滚动缓存区
config.scrollback_lines = 3500
config.keys = {
	-- 水平分屏：Cmd+D
	{
		key = "=",
		mods = "LEADER",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- 竖直分屏：Cmd+Shift+D
	{
		key = "-",
		mods = "LEADER",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- 切换分屏：Ctrl+H/J/K/L
	{
		key = "h",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Right"),
	},
	-- 关闭分屏：Cmd+X
	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	-- 新 Tab：Cmd+T
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	-- 调整分屏大小（Vim style）
	{
		key = "h",
		mods = "SUPER|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "j",
		mods = "SUPER|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "k",
		mods = "SUPER|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "l",
		mods = "SUPER|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},
	-- 进入复制模式
	{
		key = " ",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},
	-- 进入快速复制模式
	{
		key = "y",
		mods = "LEADER",
		action = wezterm.action.QuickSelectArgs({
			patterns = {
				-- 常用文本模式
				"\\b\\w{3,}\\b", -- 3个字符以上的单词
				"\\b[A-Z]\\w*\\b", -- 大写开头的单词（类名等）
				"\\b[a-z_]+\\b", -- 小写单词或变量名

				-- 数字和代码相关
				"\\d{4,}", -- 4位以上数字（ID、年份等）
				"0x[0-9a-fA-F]+", -- 十六进制数
				"\\d+\\.\\d+\\.\\d+\\.\\d+", -- IP地址

				-- 网络和路径
				"https?://[^\\s]+", -- URL
				"www\\.[^\\s]+\\.[a-zA-Z]{2,}", -- 网站
				"[\\w\\-\\./]+\\.[a-zA-Z]+", -- 文件路径
				"~?/[\\w\\-\\./]+", -- 绝对/相对路径

				-- 特殊格式
				"[\\w\\.-]+@[\\w\\.-]+\\.[\\w]+", -- 邮箱地址
				"#[0-9a-fA-F]{6}", -- 十六进制颜色
				"\\$[A-Z_]+", -- 环境变量
				"\\b[A-Z_]+\\b", -- 常量
				-- '\\b[a-zA-Z]\\w*',  -- 匹配单词
			},
			alphabet = "abcdefghijklmnopqrstuvwxyz", -- 只显示字母
		}),
	},
	-- 切换tab
  { key = '[', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'LEADER', action = act.ActivateTabRelative(1) },
  {
    key = 'f',
    mods = 'SUPER',
    action = act.Search { CaseInSensitiveString = '' },
  },
}
config.colors = {
	split = "#ff6b6b", -- 焦点分屏的边框变红色
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local is_zoomed = tab.active_pane.is_zoomed

	local bg_color = "#1e1e2e"
	local fg_color = "#cdd6f4"

	-- 全屏后，修改tab-title的颜色
	if is_zoomed then
		bg_color = "#ff6b6b" -- 红色
		fg_color = "#1e1e2e"
	end
	return {
		{ Background = { Color = bg_color } },
		{ Foreground = { Color = fg_color } },
		{ Text = " " .. tab.active_pane.title .. " " },
	}
end)

config.inactive_pane_hsb = {
	saturation = 0.3, -- 降低饱和度
	brightness = 0.3, -- 降低亮度，让非活动窗格变暗
}

ai_helper.apply_to_config(config, {
	type = "http",
	api_url = local_config.api_url,
	api_key = local_config.api_key,
	model = local_config.model,
})

return config
