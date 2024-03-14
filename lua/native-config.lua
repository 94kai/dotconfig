local vim = vim

vim.g.mapleader = " "
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.history=2000
vim.o.encoding = "UTF-8"
vim.o.scrolloff = 5
vim.o.mouse = ''
vim.o.cursorline=true
vim.o.cursorcolunm=true
vim.o.incsearch = true
vim.o.cmdheight = 1
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.showcmd=true
vim.o.rule=false
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.ttimeoutlen=50
vim.o.autoread = true
vim.o.whichwrap = "<,>,[,]"
vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.opt.shortmess = vim.opt.shortmess + 'S'
-- normal下通过esc关闭高亮
-- nnoremap <Esc> :nohlsearch<cr>				

-- 复制代码高亮
vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight_yank', {}),
	desc = 'Hightlight selection on yank',
	pattern = '*',
	callback = function()
		vim.highlight.on_yank { higroup = 'IncSearch', timeout = 100 }
	end,
})

