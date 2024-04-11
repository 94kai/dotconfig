require('lspconfig').pylsp.setup {}
keymap("n", "<F5>", ":!python3 %<CR>", {})
