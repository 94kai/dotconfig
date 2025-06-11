-- 所有插件都放在这里
require("plugins.customs.bufonly")
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
				{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
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
    	-- 通过p/P粘贴之后，可以通过c-n c-p来切换粘贴的内容
    	"svermeulen/vim-yoink",
    	config = function ()
    		vim.cmd("nmap <c-n> <plug>(YoinkPostPasteSwapBack)")
    		vim.cmd("nmap <c-p> <plug>(YoinkPostPasteSwapForward)")
    		vim.cmd("nmap p <plug>(YoinkPaste_p)")
    		vim.cmd("nmap P <plug>(YoinkPaste_P)")

    		-- Also replace the default gp with yoink paste so we can toggle paste in this case too
    		-- vim.cmd("nmap gp <plug>(YoinkPaste_gp)")
    		-- vim.cmd("nmap gP <plug>(YoinkPaste_gP)")

    		vim.g.yoinkSavePersistently = 1
    	end
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
    {
      "vim-scripts/ReplaceWithRegister",
      event = "VeryLazy",
      config = function()
        require("plugins.replace-with-register")
      end,
    },
    -- {
    --   "karb94/neoscroll.nvim",
    --   config = function()
    --     require("plugins.neoscroll")
    --   end,
    -- },
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
      "williamboman/mason.nvim",
      event = "VeryLazy",
      opts = {
        registries = {
          "github:mason-org/mason-registry",
        },
      },
    },
    {
      -- lsp的配置
      "neovim/nvim-lspconfig",
      event = "VeryLazy",
      config = function()
        require("plugins.lsp.lsp-config")
      end,
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
      keys = {
        { "<leader>ff", mode = { "n" }, ":FzfLua files<CR>" },
        { "<leader>fg", mode = { "n" }, ":FzfLua live_grep_glob<CR>" },
        { "<leader>fv", mode = { "n" }, ":FzfLua git_bcommits<CR>" },
        { "<A-f>", mode = { "n" }, ":FzfLua<CR>" },
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
    {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function()
        vim.fn["mkdp#util#install"]()
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
    {
      "skywind3000/vim-preview",
      event = "VeryLazy",
      config = function()
        vim.cmd("autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>")
        vim.cmd("autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>")
      end,
    },
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
    {
      "xiantang/darcula-dark.nvim",
      event = "VeryLazy",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("plugins.theme")
      end,
    },
    {
      "tris203/precognition.nvim",
      event = "VeryLazy",
      --event = "VeryLazy",
      opts = {
        startVisible = false,
        -- showBlankVirtLine = true,
        -- highlightColor = { link = "Comment" },
        -- hints = {
        --      Caret = { text = "^", prio = 2 },
        --      Dollar = { text = "$", prio = 1 },
        --      MatchingPair = { text = "%", prio = 5 },
        --      Zero = { text = "0", prio = 1 },
        --      w = { text = "w", prio = 10 },
        --      b = { text = "b", prio = 9 },
        --      e = { text = "e", prio = 8 },
        --      W = { text = "W", prio = 7 },
        --      B = { text = "B", prio = 6 },
        --      E = { text = "E", prio = 5 },
        -- },
        -- gutterHints = {
        --     G = { text = "G", prio = 10 },
        --     gg = { text = "gg", prio = 9 },
        --     PrevParagraph = { text = "{", prio = 8 },
        --     NextParagraph = { text = "}", prio = 8 },
        -- },
      },
    },
  }
end
