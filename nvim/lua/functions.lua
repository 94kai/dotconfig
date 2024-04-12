-- Global functions
_G.vim = vim
function _G.pRequire(name)
  local status_ok, plugin = pcall(require, name)
  if not status_ok then
    vim.notify(" Can't find: " .. name)
    return nil
  end
  return plugin
end

function _G.keymap(mode, lhs, rhs, opts)
  if not lhs or not rhs then
    return
  end

  local keyOpts = vim.tbl_extend("force", { remap = false, silent = true }, (opts or {}))

  if type(lhs) == "table" then
    for _, x in pairs(lhs) do
      vim.keymap.set(mode, x, rhs, keyOpts)
    end
    return
  end

  vim.keymap.set(mode, lhs, rhs, keyOpts)
end


function _G.delkeymap(mode, lhs)
  vim.keymap.del(mode, lhs)
end

function _G.isWSL()
  local output = vim.fn.systemlist("uname -r")
  return not not string.find(output[1] or "", "WSL")
end

