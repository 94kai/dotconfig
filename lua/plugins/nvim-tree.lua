-- 目录
local nvimTree = pRequire("nvim-tree")
if nvimTree then
  keymap("n", "<C-t>", "<CMD>NvimTreeToggle<CR>")
  keymap("n", "<C-f>", "<CMD>NvimTreeFocus<CR>")
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
      -- hide dot files
      dotfiles = true,
      -- hide node_modules folder
      -- custom = { "node_modules" },
    },
    view = {
      width = 34,
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
      root_folder_label = true,
      indent_markers = {
        enable = false,
        icons = {
          corner = "└ ",
          edge = "│ ",
          none = "  ",
        },
      },
      icons = {
        webdev_colors = true,
        git_placement = "after",
      },
    },
  })
end
