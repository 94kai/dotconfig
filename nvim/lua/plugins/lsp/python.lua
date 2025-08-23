-- vim.api.nvim_exec([[ autocmd FileType python nnoremap <buffer> <F5> :!python %<CR>]], false)

vim.lsp.config('pylsp', {
    settings = {
      pylsp = {
        plugins = {
          pycodestyle = {
            ignore = {'W391'},
            maxLineLength = 100
          }
        }
      }
    }
  })
vim.lsp.enable("pylsp")