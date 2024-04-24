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
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	},
	{
		"unblevable/quick-scope",
	},
	{
		"easymotion/vim-easymotion",
		config = function()
			require("plugins.easymotion")
		end,
	},
	{
		"vim-scripts/ReplaceWithRegister",
		config = function()
			require("plugins.replace-with-register")
		end
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
	{
		"voldikss/vim-floaterm",
		config = function()
			require("plugins.floaterm")
		end,
	},
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
		}
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
		-- 补全插件
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/vim-vsnip"
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
		"junegunn/fzf.vim",
		dependencies = {
			"junegunn/fzf"
		},
		config = function()
			require("plugins.fzf")
		end
	},
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'theHamsta/nvim-dap-virtual-text', -- 代码旁边显示变量数据
			"nvim-neotest/nvim-nio",  -- 提供异步能力
			"rcarriga/nvim-dap-ui",   -- 调试UI窗口
		},
		config = function()
			require("plugins.dap.dap-config")
		end
	},
	{
		'voldikss/vim-translator',
		config = function()
			require('plugins.vim-translator')
		end
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	{
		"yegappan/taglist",
		config = function()
			require("plugins.taglist")
		end
	},
	{
		"dhananjaylatkar/cscope_maps.nvim",
		dependencies = {
			"folke/which-key.nvim", -- optional [for whichkey hints]
			-- "nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
			-- "ibhagwan/fzf-lua",     -- optional [for picker="fzf-lua"]
			-- "nvim-tree/nvim-web-devicons", -- optional [for devicons in telescope or fzf]
		},
		opts = {
			-- USE EMPTY FOR DEFAULT OPTIONS
			-- DEFAULTS ARE LISTED BELOW
		},
		config = function()
			require("plugins.cscope_maps")
		end
	}
}
