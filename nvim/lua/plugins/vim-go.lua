vim.g.go_list_type = "quickfix"

keymap("n", "<C-m>", ":cprevious<CR>")
vim.cmd("autocmd FileType go nmap <leader>t  <Plug>(go-test)")

vim.api.nvim_exec([[ autocmd FileType go nnoremap <buffer> gr :GoReferrers<CR> ]], false)
vim.api.nvim_exec([[ autocmd FileType go nnoremap <buffer> gi :GoImplements<CR> ]], false)
