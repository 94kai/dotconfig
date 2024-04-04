vim.g.go_list_type = "quickfix"

vim.api.nvim_exec([[ autocmd FileType go nnoremap <buffer> gr :GoReferrers<CR> ]], false)
vim.api.nvim_exec([[ autocmd FileType go nnoremap <buffer> gi :GoImplements<CR> ]], false)
