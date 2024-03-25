-- servier confit: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
require('lspconfig').jdtls.setup({})
-- require('lspconfig').bashls.setup({})
require('lspconfig').lua_ls.setup {}
require('lspconfig').gopls.setup {}

keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
-- code action
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
-- go xx
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", {})
-- diagnostic
keymap("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
keymap("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
keymap("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", {})
vim.cmd("command! F lua vim.lsp.buf.format()")
