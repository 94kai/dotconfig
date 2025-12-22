-- require("plugins.lsp.go")
-- require("plugins.lsp.json")
require("plugins.lsp.python")
-- servier confit: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
vim.lsp.enable('lua_ls')
-- vim.lsp.config('lua_ls', {
--   on_init = function(client)
--     if client.workspace_folders then
--       local path = client.workspace_folders[1].name
--       if
--         path ~= vim.fn.stdpath('config')
--         and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
--       then
--         return
--       end
--     end
--
--     client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
--       runtime = {
--         -- Tell the language server which version of Lua you're using (most
--         -- likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT',
--         -- Tell the language server how to find Lua modules same way as Neovim
--         -- (see `:h lua-module-load`)
--         path = {
--           '?.lua',
--           '?.lua',
--         },
--       },
--       -- Make the server aware of Neovim runtime files
--       workspace = {
--         checkThirdParty = false,
--         library = {
--           vim.env.VIMRUNTIME
--           -- Depending on the usage, you might want to add additional paths
--           -- here.
--           -- '${3rd}/luv/library'
--           -- '${3rd}/busted/library'
--         }
--         -- Or pull in all of 'runtimepath'.
--         -- NOTE: this is a lot slower and will cause issues when working on
--         -- your own configuration.
--         -- See https://github.com/neovim/nvim-lspconfig/issues/3189
--         -- library = {
--         --   vim.api.nvim_get_runtime_file('', true),
--         -- }
--       }
--     })
--   end,
--   settings = {
--     Lua = {}
--   }
-- })
-- 重命名
keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
-- code action
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
-- 跳转
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {})
keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {})
keymap("n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", {})
-- diagnostic 查看诊断信息
keymap("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", {})
keymap("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {})
keymap("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", {})

-- 控制引用列表的导航(如查找到多个引用)
keymap("n", "<leader>k", ":cprevious<CR>")
keymap("n", "<leader>j", ":cnext<CR>")
keymap("n", "<leader>l", ":cclose<CR>")
