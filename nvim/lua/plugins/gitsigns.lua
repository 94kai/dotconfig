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
		signs = {
			add = { hl = "GitSignsAdd", text = "+|", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change = { hl = "GitSignsChange", text = "c|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			delete = { hl = "GitSignsDelete", text = "d_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			topdelete = { hl = "GitSignsDelete", text = "d‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			changedelete = { hl = "GitSignsChange", text = "d~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		},
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
		current_line_blame_formatter_opts = {
			relative_time = false,
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
		yadm = {
			enable = false,
		},
		-- I'm not gona remember these keys for now, let's use code action
		-- on_attach = gitsigns_on_attach,
	})
end
keymap("n", "<leader>gdt", ":Gitsigns diffthis<CR>")
keymap("n", "<leader>gbl", ":Gitsigns blame_line<CR>")
keymap("n", "<leader>gc", ":-close<CR>")
