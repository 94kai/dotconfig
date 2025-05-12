require("functions")
require("native-config")
require("autocmds")
-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.print("下载Lazy中，请等待。。。")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
else
	vim.opt.rtp:prepend(lazypath)
	require("lazy").setup(require("plugin-list"))
end

-- 引入vimscript start
local nvim_config_dir = vim.fn.stdpath('config')
vim.cmd('source ' .. nvim_config_dir .. '/vimscript/argtextobj.vim')
-- 引入vimscript end

