-- servier confit: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
require('lspconfig').jdtls.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').lua_ls.setup {}

keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
-- code action
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
-- go xx
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
-- diagnostic
keymap("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
keymap("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
keymap("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
vim.cmd("command! F lua vim.lsp.buf.format()")
