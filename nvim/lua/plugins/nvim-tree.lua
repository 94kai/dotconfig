-- 目录
local function get_tree_width()
  local columns = vim.o.columns
  local width_percent = 0.2 -- 设置为窗口宽度的20%
  local width = math.floor(columns * width_percent)
  return width
end
local nvimTree = pRequire("nvim-tree")
if nvimTree then
  keymap("n", "<C-f>", "<CMD>NvimTreeToggle<CR>")
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  nvimTree.setup({
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    git = {
      enable = true,
      ignore = true,
    },
    filters = {
      git_ignored = false,
      dotfiles = false,
    },
    view = {
      width = get_tree_width(), -- 初始化宽度
      -- or 'right'
      side = "left",
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
    actions = {
      open_file = {
        resize_window = true,
        quit_on_open = false,
      },
    },
    renderer = {
      root_folder_label = ":~:s?$?/..?",
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          bottom = "─",
          none = " ",
        },
      },
    },
  })
end
