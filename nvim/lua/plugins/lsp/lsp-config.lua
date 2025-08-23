-- require("plugins.lsp.go")
-- require("plugins.lsp.json")
require("plugins.lsp.python")
-- servier confit: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
require("lspconfig").lua_ls.setup({})

-- 重命名
keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
-- code action
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
-- 跳转
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", {})
-- diagnostic 查看诊断信息
keymap("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
keymap("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
keymap("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", {})


-- 控制引用列表的导航(如查找到多个引用)
keymap("n", "<leader>k", ":cprevious<CR>")
keymap("n", "<leader>j", ":cnext<CR>")
keymap("n", "<leader>l", ":cclose<CR>")
