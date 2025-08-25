local vim = vim

vim.g.mapleader = " "
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.history = 2000
vim.o.encoding = "UTF-8"
vim.o.scrolloff = 5
vim.o.mouse = "a"
vim.o.cursorline = true
vim.o.incsearch = true
vim.o.cmdheight = 1
vim.o.number = true
vim.o.relativenumber = false
vim.o.showmode = false
vim.o.termguicolors = true
vim.o.showcmd = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.ttimeoutlen = 50
vim.o.timeoutlen = 3000
vim.o.autoread = true
vim.o.whichwrap = "<,>,[,]"
vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.opt.shortmess = vim.opt.shortmess + "S"
vim.o.undofile = true
-- 使用+ *寄存器进行默认的y/c/d/p等。mac/linux上+/*同步
vim.o.clipboard = "unnamedplus"
-- 复制代码高亮
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
  end,
})
-- 会导致批量修改文本卡顿
-- vim.o.foldmethod = "indent"
-- 设置很高的折叠级别，使默认不折叠
vim.o.foldlevel = 99
-- 移除空行前面的波浪
vim.opt.fillchars = { eob = " " }
-- keymap({"n","v","o"}, "H", "0")
-- keymap({"n","v","o"}, "L", "$")
-- keymap({"n","v","o"}, "<leader>j", "%")
-- keymap("n", "<leader>h", ":bp<CR>")
-- keymap("n", "<leader>l", ":bn<CR>")
keymap("n", "H", ":bp<CR>")
keymap("n", "L", ":bn<CR>")

-- keymap("n", "<C-n>", ":cnext<CR>")
-- keymap("n", "<C-m>", ":cprevious<CR>")

-- normal模式下和tmux冲突,所以暂不支持normal模式
-- 快速移动一行
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv")
–– 与窗口导航冲突，注释掉
-- keymap("n", "<C-j>", ":m .+1<CR>==")
-- keymap("n", "<C-k>", ":m .-2<CR>==")

-- 终端中ESC直接回到normal模式
keymap("t", "<C-[>", "<C-\\><C-n>", { noremap = true })

-- tab相关
keymap("n", "<Tab>c", ":tab split<CR>") -- 新建标签
keymap("n", "<Tab>x", ":tabclose<CR>") -- 关闭标签
keymap("n", "<Tab>n", ":tabprev<CR>") -- 上一个标签
keymap("n", "<Tab>p", ":tabnext<CR>") -- 下一个标签
keymap("n", "<Tab>1", ":tabn1<CR>")
keymap("n", "<Tab>2", ":tabn2<CR>")
keymap("n", "<Tab>3", ":tabn3<CR>")
keymap("n", "<Tab>4", ":tabn4<CR>")
keymap("n", "<Tab>5", ":tabn5<CR>")
keymap("n", "<Tab>6", ":tabn6<CR>")
keymap("n", "<Tab>7", ":tabn7<CR>")
keymap("n", "<Tab>8", ":tabn8<CR>")
keymap("n", "<Tab>9", ":tabn9<CR>")
keymap("n", "<Tab>0", ":tabn0<CR>")
