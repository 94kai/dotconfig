require("lspconfig").pylsp.setup({})
vim.api.nvim_exec([[ autocmd FileType python nnoremap <buffer> <F5> :!python %<CR>]], false)
