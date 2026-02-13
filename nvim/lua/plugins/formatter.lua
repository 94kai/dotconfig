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
-- augroup("__formatter__", { clear = true })
-- autocmd("BufWritePost", {
--   group = "__formatter__",
--   command = "lua _G.format_if_small_enough()",
-- })

vim.cmd("command! F :Format")


local function replace_escaped_quotes()
  vim.cmd([[silent keepjumps keeppatterns %s/\\"/"/ge]])
end

local function format_jsonc()
  local saved_view = vim.fn.winsaveview()
  vim.cmd("setfiletype jsonc")
  vim.cmd(":%!prettier --parser jsonc")
  vim.fn.winrestview(saved_view)
end
local function format_json()
  local saved_view = vim.fn.winsaveview()
  vim.cmd("setfiletype json")
  vim.cmd(":%!prettier --parser json")
  vim.fn.winrestview(saved_view)
end

local function format_jsonc_escaped_quotes()
  local saved_view = vim.fn.winsaveview()
  vim.cmd("setfiletype jsonc")
  replace_escaped_quotes()
  vim.cmd(":%!prettier --parser jsonc")
  vim.fn.winrestview(saved_view)
end
local function format_json_escaped_quotes()
  local saved_view = vim.fn.winsaveview()
  vim.cmd("setfiletype jsonc")
  replace_escaped_quotes()
  vim.cmd(":%!prettier --parser json")
  vim.fn.winrestview(saved_view)
end
vim.api.nvim_create_user_command("FJson", format_json, {})
vim.api.nvim_create_user_command("FJsonc", format_jsonc, {})
vim.api.nvim_create_user_command("FJsonEscaped", format_json_escaped_quotes, {})
vim.api.nvim_create_user_command("FJsoncEscaped", format_jsonc_escaped_quotes, {})

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
    python = {
      require("formatter.filetypes.python").autopep8,
    },
    sh = {
      require("formatter.filetypes.sh").shfmt,
    },
    lua = {
      require("formatter.filetypes.lua").stylua,
    },
		java ={
			require("formatter.filetypes.java").google_java_format
		},
    typescript = {
      require("formatter.filetypes.typescript").prettier,
    },
    javascript = {
      require("formatter.filetypes.javascript").jsbeautify,
    },
    cpp = {
      require("formatter.filetypes.cpp").clangformat,
    },
    kotlin = {
      function()
        return {
          exe = "ktfmt",
          args = { "--kotlinlang-style" },
          stdin = false,
        }
      end,
    },
    json = {
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath",
            vim.api.nvim_buf_get_name(0),
          },
          stdin = true,
        }
      end,
    },
    json5 = {
      function()
        return {
          exe = "prettier",
          args = {
						"--parser",
						"jsonc",
            "--stdin-filepath",
            vim.api.nvim_buf_get_name(0),
          },
          stdin = true,
        }
      end,
    },
    jsonc = {
      function()
        return {
          exe = "prettier",
          args = {
						"--parser",
						"jsonc",
            "--stdin-filepath",
            vim.api.nvim_buf_get_name(0),
          },
          stdin = true,
        }
      end,
    },
  },
})
