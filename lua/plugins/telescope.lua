return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	cmd = "Telescope",
	opts = {
		defaults = {
			sorting_strategy = "ascending",
			prompt_prefix = " ",
			selection_caret = " ",
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
	end,
	keys = {
		{ "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Find buffer" },
		{ "<leader>bs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search buffer" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Recent file" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file" },
		{ "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Search files" },
		{ "<F1>", "<cmd>Telescope help_tags<cr>", desc = "Search help", mode = { "n", "i" } },
	},
}
