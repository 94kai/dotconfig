-- Utilities for creating configurations
local util = require("formatter.util")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
-- 创建一个Lua函数，用于判断文件大小并执行格式化
_G.format_if_small_enough = function()
  local filename = vim.fn.expand("%:p") -- 获取当前文件的完整路径
  local size = vim.fn.getfsize(filename) -- 获取文件大小
  if size < 1024 * 100 then -- 如果文件大小小于100k
    vim.cmd("FormatWrite") -- 执行格式化
  end
end
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
  group = "__formatter__",
  command = "lua _G.format_if_small_enough()",
})

vim.cmd("command! F :Format")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- 需要先安装stylua： brew install stylua
      require("formatter.filetypes.lua").stylua,
    },
    python = {
      -- 需要先安装black：pip3 install git+https://github.com/psf/black
      require("formatter.filetypes.python").black,
    },
    json = {
      require("formatter.filetypes.json").prettier,
    },
    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    -- ["*"] = {
    --   -- "formatter.filetypes.any" defines default configurations for any
    --   -- filetype
    --   require("formatter.filetypes.any").remove_trailing_whitespace,
    -- },
  },
})
