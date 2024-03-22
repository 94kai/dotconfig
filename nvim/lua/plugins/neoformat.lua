vim.cmd("command! Format Neoformat")
-- 支持shell。go install mvdan.cc/sh/v3/cmd/shfmt@latest，然后把go的bin添加到环境变量
vim.g.shfmt_opt = "-ci"
