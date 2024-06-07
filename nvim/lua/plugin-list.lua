-- 所有插件都放在这里
require("plugins.customs.bufonly")
local status, ignorePlugin = pcall(require, "ignore-config")

if not status then
  ignorePlugin = {}
end
return {
  ignorePlugin,
  {
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.nvim-notify")
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvim-tree")
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
  {
    "unblevable/quick-scope",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- {
  -- 用flash的s代替
  -- 	"easymotion/vim-easymotion",
  -- 	config = function()
  -- 		require("plugins.easymotion")
  -- 	end,
  -- },
  {
    "vim-scripts/ReplaceWithRegister",
    config = function()
      require("plugins.replace-with-register")
    end,
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-y>", "zt", "zz", "zb" }, -- 移除对<C-f>的映射，留给nvim-tree,移除对<C-e>的映射，留给%
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("plugins.rainbow-delimiters")
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.comment")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
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
    "folke/tokyonight.nvim",
    config = function()
      require("plugins.theme")
    end,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
    config = function()
      require("plugins.theme")
    end,
  },
  -- 主题---------------
  {
    "lewis6991/gitsigns.nvim",
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
    -- 中文文档插件（需要克隆文档参考https://github.com/yianwillis/vimcdocF
  },
  {
    "tpope/vim-surround",
  },
  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
      },
    },
  },
  {
    -- lsp的配置
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lsp.lsp-config")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    -- 补全插件 会导致批量操作（normal命令）巨慢无比
    "hrsh7th/nvim-cmp",
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
    config = function()
      require("plugins.nvim-treesitter")
    end,
  },
  {
    -- 支持通过c-hjkl切换vim的window
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
    config = function()
      -- calling `setup` is optional for customization
      require("plugins.fzf")
    end,
  },
  {
    "mfussenegger/nvim-dap",
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
    config = function()
      require("plugins.vim-translator")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "yegappan/taglist",
    config = function()
      require("plugins.taglist")
    end,
  },
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
  {
    "skywind3000/vim-preview",
    config = function()
      vim.cmd("autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>")
      vim.cmd("autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>")
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
			modes = {
				char  ={
					enabled = false
				}
			}
		},
		-- stylua: ignore
		keys = {
			{ "<leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
			{ "<leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			-- 	{ "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
			-- 	{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			-- 	{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      require("plugins.formatter")
    end,
  },
}
