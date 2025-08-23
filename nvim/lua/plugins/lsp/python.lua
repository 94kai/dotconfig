# python调试方式
-- python -m pudb xxx.py
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
