vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.log",
  callback = function()
    vim.bo.filetype = "log"
  end,
})
