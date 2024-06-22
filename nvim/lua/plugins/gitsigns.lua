-- 展示git信息
local gitsigns = pRequire("gitsigns")
local cfg = {
	enable = true,
	code_actions = "gitsigns",
	-- sign display
	signcolumn = true,       -- Toggle with `:Gitsigns toggle_signs`
	numhl = true,            -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false,          -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false,       -- Toggle with `:Gitsigns toggle_word_diff`
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
}
if gitsigns and cfg and cfg.enable then
	gitsigns.setup({
		--  A for add
		--  C for change
		--  D for delete
		-- sign display
		signcolumn = cfg.signcolumn, -- Toggle with `:Gitsigns toggle_signs`
		-- do not highlight line number
		numhl = cfg.numhl,     -- Toggle with `:Gitsigns toggle_numhl`
		linehl = cfg.linehl,   -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = cfg.word_diff, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = cfg.current_line_blame, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
		},
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000,
		preview_config = {
			-- Options passed to nvim_open_win
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		-- I'm not gona remember these keys for now, let's use code action
		-- on_attach = gitsigns_on_attach,
	})
end
keymap("n", "<leader>Gd", ":Gitsigns diffthis<CR>")
keymap("n", "<leader>Gb", ":Gitsigns blame_line<CR>")
keymap("n", "<leader>Gc", ":-close<CR>")
keymap("n", "<leader>Gp", ":Gitsigns preview_hunk<CR>")
keymap("n", "<leader>Gr", ":Gitsigns reset_hunk<CR>")
