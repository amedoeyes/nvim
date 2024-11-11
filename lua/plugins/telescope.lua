return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			lazy = true,
		},
	},
	lazy = true,
	cmd = "Telescope",
	opts = function()
		local actions = require("telescope.actions")
		return {
			defaults = {
				sorting_strategy = "ascending",
				prompt_prefix = " ",
				selection_caret = " ",
				mappings = {
					i = {
						["<c-d>"] = actions.delete_buffer,
					},
				},
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
	end,
	keys = {
		{ "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Find buffer" },
		{ "<leader>bs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search buffer" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find recent file" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file" },
		{ "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Search files" },
		{ "<F1>", "<cmd>Telescope help_tags<cr>", desc = "Find help", mode = { "n", "i" } },
	},
}
