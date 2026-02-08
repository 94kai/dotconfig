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

config.mouse_bindings = {
	-- 禁用普通左键点击打开链接
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.CompleteSelection("PrimarySelection"),
	},

	-- Command + 左键 才打开链接
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SUPER",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.use_fancy_tab_bar = true -- tab样式
config.tab_bar_at_bottom = false -- tab 栏位置

local search_mode = wezterm.gui.default_key_tables().search_mode
-- 连按两次Super-f 清空搜索词
table.insert(search_mode, {
	key = "f",
	mods = "SUPER",
	action = act.Multiple({
		act.CopyMode("ClearPattern"),
		act.ClearSelection,
		act.CopyMode("ClearSelectionMode"),
		-- act.CopyMode("MoveToScrollbackBottom"),
	}),
})
-- 搜索模式下回车进入copy-mode
table.insert(search_mode, { key = "Enter", mods = "NONE", action = "ActivateCopyMode" })

local copy_mode = wezterm.gui.default_key_tables().copy_mode
-- copy模式下，按/，进入搜索模式
table.insert(copy_mode, { key = "/", mods = "NONE", action = act.Search({ CaseInSensitiveString = "" }) })
-- copy模式下，通过n/S-n跳转匹配项
table.insert(copy_mode, { key = "n", mods = "NONE", action = act.CopyMode("NextMatch") })
table.insert(copy_mode, { key = "n", mods = "SHIFT", action = act.CopyMode("PriorMatch") })

-- Update key tables with new keys
config.key_tables = {
	search_mode = search_mode,
	copy_mode = copy_mode,
}

wezterm.on("update-status", function(window, pane)
	local leader_active = window:leader_is_active()
	local key_table = window:active_key_table()

	local bg_color, fg_color, fg_color_default, bg_color_default
	fg_color_default = "#b2b2b2"
	bg_color_default = "#313244"

	local cwd = pane:get_current_working_dir()
	local text = (cwd and cwd.file_path or "")
	local mode = " NORMAL "
	if leader_active then
		bg_color = "#fab387" -- 橙色
		fg_color = "#1e1e2e"
		mode =   "  LEADER  "
	elseif key_table == "copy_mode" then
		bg_color = "#9ece6a"
		fg_color = "#1e1e2e"
		mode =   "    COPY    "
	elseif key_table == "search_mode" then
		bg_color = "#89b4fa"
		fg_color = "#1e1e2e"
		mode = " SEARCH  "
	elseif key_table then
		bg_color = "#cba6f7"
		fg_color = "#1e1e2e"
	else
		bg_color = "#313244"
		fg_color = "#b2b2b2"
	end

	window:set_left_status(wezterm.format({

		{ Background = { Color = bg_color } },
		{ Foreground = { Color = fg_color } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = mode },
	}))

	window:set_right_status(wezterm.format({

		{ Background = { Color = bg_color_default } },
		{ Foreground = { Color = fg_color_default } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = text },
		{ Text = "  " },
	}))
end)
config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", weight = "Medium" },
	{ family = "Maple Mono NF", weight = "Medium" }, -- 备选，支持中文和 Nerd Font
	"PingFang SC", -- 中文回退、
})
-- config.window_background_image = "/Users/xuekai/Documents/itermbg_dontdel.jpg"
-- config.window_background_image_opacity = 0.55  -- 很淡
-- 背景图的缩放模式
-- config.window_background_image_hsb = {
-- 	brightness = 0.05, -- 降低亮度让文字更清楚
-- }
-- config.window_background_opacity = 0.89 -- 整个窗口透明度
-- config.macos_window_background_blur = 5 -- 背景模糊
config.window_close_confirmation = "NeverPrompt"
-- config.disable_default_key_bindings = true
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1500 }
-- 滚动缓存区
config.scrollback_lines = 3500
config.keys = {
	-- Rename Tab Title
	{
		key = "r",
		mods = "SUPER",
		action = act.PromptInputLine({
			description = "Rename tab:",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{ key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackAndViewport") },
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
	-- 切换Tab
	{ key = "=", mods = "SUPER", action = act.ActivateTabRelative(1) },
	{ key = "-", mods = "SUPER", action = act.ActivateTabRelative(-1) },
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
		key = "s",
		mods = "LEADER",
		action = wezterm.action.QuickSelectArgs({
			patterns = {
				"https?://[^\\s]+", -- URL
				"~?/[\\w\\-\\./]+", -- 绝对/相对路径
				"0x[0-9a-fA-F]+", -- 十六进制数
				"#[0-9a-fA-F]{6}", -- 十六进制颜色
				"[\\w\\-\\./]+\\.[a-zA-Z]+", -- 文件路径
				"\\b[A-Z]\\w*\\b", -- 大写开头的单词（类名等）
				"\\b[a-z_]+\\b", -- 小写单词或变量名
			},
			alphabet = "abcdefghijklmnopqrstuvwxyz", -- 只显示字母
		}),
	},
	-- {
	-- 	key = "f",
	-- 	mods = "SUPER",
	-- 	action = act.Search({ CaseInSensitiveString = "" }),
	-- },
}
config.colors = {
	split = "#ff6b6b", -- 焦点分屏的边框变红色
}

function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = tab_title(tab)
	if #title > 10 then
		title = ".." .. string.sub(title, -12)
	end
	local is_zoomed = tab.active_pane.is_zoomed
	if tab.is_active and is_zoomed then
		return {
			{ Background = { Color = "#73daca" } },
			{ Foreground = { Color = "black" } },
			{ Text = " " .. title .. " " },
		}
	end
	-- 触发一下is_last_active，tab的序号就能展示，怀疑是一个bug，还必须在is_zoomed后面执行
	-- local _ = tab.is_last_active
	return " " .. title .. " "
end)

config.inactive_pane_hsb = {
	saturation = 0.7, -- 降低饱和度
	brightness = 0.3, -- 降低亮度，让非活动窗格变暗
}

ai_helper.apply_to_config(config, {
	type = "http",
	api_url = local_config.api_url,
	api_key = local_config.api_key,
	model = local_config.model,
})

return config
