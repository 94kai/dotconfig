-- 最下面的状态栏
local lualine = pRequire("lualine")

if lualine then
	lualine.setup({
		options = {
			-- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
			theme =  "moonfly",
			component_separators = {
				left = "|",
				right = "|",
			},
			-- https://github.com/ryanoasis/powerline-extra-symbols
			section_separators = {
				left = " ",
				right = "",
			},
		},
		extensions = { "nvim-tree" },
		sections = {
			lualine_c = {
				{
					"filename",
					file_status = true, -- displays file status (readonly status, modified status)
					path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
				},
			},

			-- lualine_a = {
			-- },
			lualine_x = {
				'%{ZFVimIME_IMEStatusline()}',
				{
					'searchcount',
					maxcount = 99999,
					timeout = 500,
				},
				"filesize",
				"encoding",
				"filetype",
			},
		},
	})
end
