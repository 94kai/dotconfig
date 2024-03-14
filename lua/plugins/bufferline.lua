-- 类似vs的tab栏 
local bufferline = pRequire("bufferline")
if bufferline then
  bufferline.setup({
    options = {
		numbers = function(opts)
    return string.format('%s', opts.id)
  end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  })
end
