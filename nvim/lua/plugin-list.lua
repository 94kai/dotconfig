-- 所有插件都放在这里
return {
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
	{ "vim-scripts/ReplaceWithRegister" },
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
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-jdtls",
			"mfussenegger/nvim-dap",
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:nvim-java/mason-registry",
						"github:mason-org/mason-registry",
					},
				},
			},
			config = function()
				require('java').setup()
			end,
		},
	},
	{
		-- lsp的配置
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lspconfig")
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
			"neovim/nvim-lspconfig",
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
		"fatih/vim-go",
		config = function()
			require("plugins.vim-go")
		end,
	},
}
