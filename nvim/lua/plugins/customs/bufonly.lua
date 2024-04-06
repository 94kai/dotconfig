function BufOnly(buffer)
	vim.cmd(":only")
	local bufNum
	if buffer == '' then
		bufNum = vim.fn.bufnr("%")
	else
		bufNum = tonumber(buffer)
		if bufNum == nil then
			return
		end
		-- 跳转到only的buf
		vim.cmd("b" .. bufNum)
	end

	-- 最后一个缓存区的num
	local lastBufNum = vim.fn.bufnr("$")
	local deleteCount = 0
	local n = 1
	while n <= lastBufNum do
		-- n不是当前缓存区，且在缓存区列表
		if (n ~= bufNum) and (vim.fn.buflisted(n) ~= 0) and (vim.fn.getbufvar(n, '&modified') == 0) then
			deleteCount = deleteCount + 1
			vim.cmd(":bd " .. n)
		end
		n = n + 1
	end
	print(deleteCount .. " buffers deleted")
end

vim.cmd("command! -nargs=? Bo :lua BufOnly('<args>')")
