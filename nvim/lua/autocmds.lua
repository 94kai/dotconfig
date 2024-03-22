local vim = vim
local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup",{})

local autocmd = vim.api.nvim_create_autocmd
local lastTime = os.time()
autocmd("InsertLeave", {
	group = myAutoGroup,
	callback = function()
		-- 用job去优化批量任务导致的耗时问题
		if os.time()-lastTime>1 then
			vim.cmd("call jobstart('im-select com.apple.keylayout.ABC')")
			lastTime = os.time()
		end
	end
})


-- https://www.reddit.com/r/neovim/comments/zc720y/tip_to_manage_hlsearch/
-- 添加一个id为第二个参数的listener
vim.on_key(function(char)
	-- normal下，按键包含xxx，开启hlsearch，否则关闭
	if vim.fn.mode() == "n" then
		vim.opt.hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
	end
end, vim.api.nvim_create_namespace("auto_hlsearch"))



-- save fold
autocmd("BufWinEnter", {
	group = myAutoGroup,
	pattern = "*",
	command = "silent! loadview",
})

autocmd("BufWrite", {
	group = myAutoGroup,
	pattern = "*",
	command = "mkview",
})

autocmd("BufRead", {
	group = myAutoGroup,
	callback = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			command = "normal! zx zR",
		})
	end,
})
