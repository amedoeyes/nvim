return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	event = "VimEnter",
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
			indent = { with_expanders = true },
		},
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)

		vim.api.nvim_create_autocmd("TermClose", {
			group = vim.api.nvim_create_augroup("lazygit_close", { clear = true }),
			pattern = "*lazygit*",
			callback = function()
				require("neo-tree.sources.git_status").refresh()
			end,
		})
	end,
	keys = {
		{
			"<leader>ft",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
			end,
			desc = "Files tree",
		},
	},
}
