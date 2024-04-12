require('lspconfig').pylsp.setup {}
vim.api.nvim_exec([[ autocmd FileType python nnoremap <buffer> <F5> :!python3 %<CR>]], false)
