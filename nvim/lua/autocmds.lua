local vim = vim
local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", {})

local autocmd = vim.api.nvim_create_autocmd
local lastTime = os.time()


-- https://www.reddit.com/r/neovim/comments/zc720y/tip_to_manage_hlsearch/
-- 添加一个id为第二个参数的listener
-- 通过%normal批量修改文本时，这里会不断被执行，导致耗时
-- vim.on_key(function(char)
-- 	-- normal下，按键包含xxx，开启hlsearch，否则关闭
-- 	if vim.fn.mode() == "n" then
-- 		vim.opt.hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
-- 	end
-- end, vim.api.nvim_create_namespace("auto_hlsearch"))

autocmd("BufRead", {
	group = myAutoGroup,
	callback = function()
		local fsize = vim.fn.getfsize(vim.fn.expand('%:p'))
		-- 文件大于10M，把filetype设置为空，避免lsp/treesitter工作
		if (fsize > 1024 * 1024 * 10) then
			vim.cmd(":set filetype=")
		end
	end
})
