-- 所有插件都放在这里
require("plugins.customs.bufonly")
require("plugins.customs.terminal")
local status, ignorePlugin = pcall(require, "ignore-config")

if not status then
  ignorePlugin = {}
end

local nvimTreeConfig = {
  "kyazdani42/nvim-tree.lua",
  config = function()
    require("plugins.nvim-tree")
  end,
}

if isOpenDir() ~= 1 then
  keymap("n", "<C-f>", "<CMD>NvimTreeToggle<CR>")
  nvimTreeConfig.cmd = { "NvimTreeToggle", "NvimTreeFocus" }
end

local commonConfig = {
  {
    -- lsp的配置
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      require("plugins.lsp.lsp-config")
    end,
  },
  {
    -- 自动括号补全
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    -- 通过s 指哪打哪
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          enabled = false,
        },
      },
    },
			-- stylua: ignore
			keys = {
				{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
				{ "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
				-- 	{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
				-- 	{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
				-- 	{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
			},
  },
  {
    -- 添加括号等包裹
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    -- 添加注释
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.comment")
    end,
  },
  {
    "unblevable/quick-scope",
    event = "VeryLazy",
  },
  {
    "vim-scripts/ReplaceWithRegister",
    -- event = "VeryLazy",
    config = function()
      require("plugins.replace-with-register")
    end,
  },
  {
    -- 通过c-x 去修改bool等值
    "tenfyzhong/axring.vim",
    config = function()
      require("plugins.axring")
    end,
  },
}
if vim.g.vscode then
  -- VSCode 扩展环境
  return {
    commonConfig,
  }
else
  -- 普通 Neovim 环境
  return {
    ignorePlugin,
    commonConfig,
    nvimTreeConfig,
    {
      -- 按"会在侧面显示寄存器列表
      "junegunn/vim-peekaboo",
    },
    {
      "esmuellert/vscode-diff.nvim",
      dependencies = { "MunifTanjim/nui.nvim" },
      cmd = "CodeDiff",
    },
    {
      -- 通过p/P粘贴之后，可以通过c-n c-p来切换粘贴的内容
      "svermeulen/vim-yoink",
      config = function()
        vim.cmd("nmap <c-n> <plug>(YoinkPostPasteSwapBack)")
        vim.cmd("nmap <c-p> <plug>(YoinkPostPasteSwapForward)")
        vim.cmd("nmap p <plug>(YoinkPaste_p)")
        vim.cmd("nmap P <plug>(YoinkPaste_P)")

        -- Also replace the default gp with yoink paste so we can toggle paste in this case too
        -- vim.cmd("nmap gp <plug>(YoinkPaste_gp)")
        -- vim.cmd("nmap gP <plug>(YoinkPaste_gP)")

        vim.g.yoinkSavePersistently = 1
      end,
    },
    {
      "rcarriga/nvim-notify",
      config = function()
        require("plugins.nvim-notify")
      end,
    },
    {
      "akinsho/bufferline.nvim",
      config = function()
        require("plugins.bufferline")
      end,
    },
    { -- 会导致有大量行数变更时，q!执行很慢
      "nvim-lualine/lualine.nvim",
      config = function()
        require("plugins.lualine")
      end,
    },
    -- {
    -- 	"folke/which-key.nvim",
    -- 	event = "VeryLazy",
    -- 	init = function()
    -- 		vim.o.timeout = true
    -- 		vim.o.timeoutlen = 1000
    -- 	end,
    -- 	opts = {
    -- 		-- your configuration comes here
    -- 		-- or leave it empty to use the default settings
    -- 		-- refer to the configuration section below
    -- 	},
    -- },
    -- {
    -- 用flash的s代替
    -- 	"easymotion/vim-easymotion",
    -- 	config = function()
    -- 		require("plugins.easymotion")
    -- 	end,
    -- },
    -- {
    --   "karb94/neoscroll.nvim",
    --   config = function()
    --     require("plugins.neoscroll")
    --   end,
    -- },
    {
      "HiPhish/rainbow-delimiters.nvim",
      event = "VeryLazy",
      config = function()
        require("plugins.rainbow-delimiters")
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      event = "VeryLazy",
      main = "ibl",
      config = function()
        require("plugins.indent-blankline")
      end,
    },
    -- {
    -- 	"voldikss/vim-floaterm",
    -- 	config = function()
    -- 		require("plugins.floaterm")
    -- 	end,
    -- },
    -- {
    -- 	'gen740/SmoothCursor.nvim',
    -- 	config = function()
    -- 		require('plugins.smooth-cursor')
    -- 	end
    -- },
    -- 主题---------------
    {
      "olimorris/onedarkpro.nvim",
      priority = 1000, -- Ensure it loads first
      config = function()
        -- 设置vscode风格的colorscheme
        vim.cmd("colorscheme onedark_dark")
        vim.cmd("highlight Visual guibg=#3498db") -- 选中的背景色
        vim.cmd("highlight Visual guifg=white") -- 选中的前景色
      end,
    },
    -- {
    --   "folke/tokyonight.nvim",
    -- event = "VeryLazy",
    --   config = function()
    --     require("plugins.theme")
    --   end,
    -- },
    -- {
    --   "bluz71/vim-moonfly-colors",
    --   name = "moonfly",
    --   priority = 1000,
    --   config = function()
    --     require("plugins.theme")
    --   end,
    -- },
    -- 主题---------------
    {
      "lewis6991/gitsigns.nvim",
      event = "VeryLazy",
      config = function()
        require("plugins.gitsigns")
      end,
    },
    -- {
    -- 	"nvim-telescope/telescope.nvim",
    -- 	tag = "0.1.5",
    -- 	dependencies = { "nvim-lua/plenary.nvim" },
    -- 	config = function()
    -- 		require("plugins.telescope")
    -- 	end,
    -- },
    {
      "yianwillis/vimcdoc",
      event = "VeryLazy",
      -- 中文文档插件（需要克隆文档参考https://github.com/yianwillis/vimcdocF
    },
    {
      -- Neovim 的便携式软件包管理器，可在 Neovim 运行的任何地方运行。 轻松安装和管理 LSP 服务器、DAP 服务器、linters 和格式化程序。
      "williamboman/mason.nvim",
      event = "VeryLazy",
      opts = {
        registries = {
          "github:mason-org/mason-registry",
        },
      },
    },
    {
      -- 补全插件 会导致批量操作（normal命令）巨慢无比
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter", "CmdlineEnter" },
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
      },
      config = function()
        require("plugins.nvim-cmp")
      end,
    },
    {
      -- 代码高亮
      "nvim-treesitter/nvim-treesitter",
      event = "VeryLazy",
      config = function()
        require("plugins.nvim-treesitter")
      end,
    },
    {
      -- 支持通过c-hjkl切换vim/tmux的window
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      },
    },
    {
      "ibhagwan/fzf-lua",
      -- for icon support
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      keys = {
        -- { "<leader>ff", mode = { "n" }, ":FzfLua files<CR>" },
        -- { "<leader>fg", mode = { "n" }, ":FzfLua live_grep_glob<CR>" },
        { "<leader>f", mode = { "n" }, ":FzfLua<CR>" },
        { "<leader>o", mode = { "n" }, ":FzfLua files<CR>" },
        { "<leader>g", mode = { "n" }, ":FzfLua live_grep<CR>" },
        { "<leader>e", mode = { "n" }, ":FzfLua oldfiles<CR>" },
      },
      config = function()
        -- calling `setup` is optional for customization
        require("plugins.fzf")
      end,
    },
    {
      "mfussenegger/nvim-dap",
      event = "VeryLazy",
      dependencies = {
        "theHamsta/nvim-dap-virtual-text", -- 代码旁边显示变量数据
        "nvim-neotest/nvim-nio", -- 提供异步能力
        "rcarriga/nvim-dap-ui", -- 调试UI窗口
      },
      config = function()
        require("plugins.dap.dap-config")
      end,
    },
    {
      "voldikss/vim-translator",
      event = "VeryLazy",
      config = function()
        require("plugins.vim-translator")
      end,
    },
    -- {
    --   "yegappan/taglist",
    --   event = "VeryLazy",
    --   config = function()
    --     require("plugins.taglist")
    --   end,
    -- },
    -- {
    -- 	"dhananjaylatkar/cscope_maps.nvim",
    -- 	dependencies = {
    -- 		"folke/which-key.nvim", -- optional [for whichkey hints]
    -- 		-- "nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
    -- 		-- "ibhagwan/fzf-lua",     -- optional [for picker="fzf-lua"]
    -- 		-- "nvim-tree/nvim-web-devicons", -- optional [for devicons in telescope or fzf]
    -- 	},
    -- 	opts = {
    -- 		-- USE EMPTY FOR DEFAULT OPTIONS
    -- 		-- DEFAULTS ARE LISTED BELOW
    -- 	},
    -- 	config = function()
    -- 		require("plugins.cscope_maps")
    -- 	end
    -- },
    -- {
    --   "skywind3000/vim-preview",
    --   event = "VeryLazy",
    --   config = function()
    --     vim.cmd("autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>")
    --     vim.cmd("autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>")
    --   end,
    -- },
    {
      "mhartington/formatter.nvim",
      event = "VeryLazy",
      config = function()
        require("plugins.formatter")
      end,
    },
    {
      "94kai/todolist.nvim",
      config = function()
        vim.cmd("autocmd FileType TodoList nnoremap <buffer> q :wqa<CR>")
        require("todolist").setup()
      end,
    },
    -- 非焦点窗口变灰色
    {
      "blueyed/vim-diminactive",
    },
    -- {
    --   -- vim内置输入法，;;进行切换。特殊环境下使用
    --   "ZSaberLv0/ZFVimIM",
    --   dependencies = {
    --     -- 提升词库加载性能
    --     "ZSaberLv0/ZFVimJob",
    --     -- 基础词库
    --     "ZSaberLv0/ZFVimIM_pinyin_base",
    --   },
    -- },
  }
end
