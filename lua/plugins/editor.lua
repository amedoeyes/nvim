return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		opts = {
			close_if_last_window = true,
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			window = {
				mappings = {
					["<space>"] = "none",
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			default_component_configs = {
				indent = {
					with_expanders = true,
				},
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				sorting_strategy = "ascending",
				prompt_prefix = " ",
				selection_caret = " ",
			},
		},
	},
	{
		"folke/flash.nvim",
		opts = {
			prompt = { enabled = false },
		},
	},
	{
		"folke/which-key.nvim",
		opts = {
			show_help = false,
			defaults = {
				mode = { "n", "v" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["gs"] = { name = "+surround" },
				["<leader>b"] = { name = "+buffers" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+files" },
				["<leader>g"] = { name = "+git" },
				["<leader>o"] = { name = "+options" },
				["<leader>q"] = { name = "+sessions" },
				["<leader>s"] = { name = "+search" },
				["<leader>t"] = { name = "+terminal" },
				["<leader>u"] = { name = "+ui" },
				["<leader>x"] = { name = "+diagnostics" },
			},
			window = {
				border = "rounded",
			},
		},
		config = function(_, opts)
			local wk = require("which-key")

			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			providers = { "lsp" },
			modes_denylist = { "v", "V" },
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
	{
		"echasnovski/mini.bufremove",
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			float_opts = {
				border = "rounded",
			},
			highlights = {
				FloatBorder = {
					link = "FloatBorder",
				},
			},
		},
		config = true,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
	},
	{
		"ahmedkhalf/project.nvim",
		lazy = false,
		opts = {
			manual_mode = true,
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
			require("telescope").load_extension("projects")
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "TroubleToggle", "Trouble" },
		opts = {
			use_diagnostic_signs = true,
		},
	},
	{ "tpope/vim-sleuth" },
}
