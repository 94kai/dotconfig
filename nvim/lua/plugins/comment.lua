-- 快速加注释的插件
local comment = pRequire("Comment")

local cfg = {
  -- normal mode
  toggler = {
    line = "gcc", -- line comment
    block = "gbc", -- block comment
  },
  -- visual mode
  opleader = {
    line = "gc",
    block = "gb",
  },
}

if comment then
  comment.setup({
    mappings = {
      -- disable extra keys
      extra = false,
    },

    -- Normal Mode
    toggler = {
      line = cfg.toggler.line, -- line comment
      block = cfg.toggler.block, -- block comment
    },
    -- Visual Mode
    opleader = {
      line = cfg.opleader.line,
      bock = cfg.opleader.block,
    },
  })
end
