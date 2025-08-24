-- 智能复用终端
-- 找到terminal类型的buffer，自动在底部开新窗口打开。否则打开一个新的终端
function smart_bottom_terminal()
  local term_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
      term_buf = buf
      break
    end
  end

  local height = math.floor(vim.o.lines * 0.2)
  vim.cmd('botright split | resize '..height)

  if term_buf then
    vim.api.nvim_set_current_buf(term_buf)
    print("Reusing terminal [Buf:"..term_buf.."]")
  else
    vim.cmd('terminal')
    print("New terminal created")
  end
  
  vim.cmd('startinsert')
end

vim.keymap.set('n', '<leader>st', smart_bottom_terminal, {desc = "Smart terminal"})

