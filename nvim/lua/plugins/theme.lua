vim.g.moonflyTransparent = true
-- vim.cmd([[colorscheme moonfly]])
vim.cmd.colorscheme("darcula-dark")
-- vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
-- local tokyonight = pRequire("tokyonight")
-- if tokyonight then
--   tokyonight.setup({
--     style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
--     transparent = false, -- Enable this to disable setting the background color
--   })
--       vim.cmd("colorscheme tokyonight")
vim.cmd("highlight Visual guibg=#3498db") -- 选中的背景色
-- vim.cmd("highlight Normal guibg=NONE") -- 背景透明
vim.cmd("highlight Visual guifg=white") -- 选中的前景色
vim.cmd("highlight Comment guifg=#6F737A") -- 注释的前景色
vim.cmd("highlight CursorLine guibg=#41435e") -- 当前行高亮的颜色
vim.cmd("highlight CursorColumn guibg=#41435e") -- 当前列高亮的颜色
vim.cmd("highlight CurSearch guifg=white guibg=blue") -- 当前列高亮的颜色
vim.cmd("highlight IncSearch guifg=white guibg=blue") -- 当前列高亮的颜色
-- end
