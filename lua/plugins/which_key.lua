return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		spec = {
			{
				mode = { "n", "v" },
				{ "[", group = "prev" },
				{ "]", group = "next" },
				{ "go", group = "operations" },
				{ "gr", group = "lsp" },
				{ "gs", group = "surround" },
				{ "<leader>b", group = "buffers" },
				{ "<leader>f", group = "files" },
				{ "<leader>g", group = "git" },
				{ "<leader>t", group = "toggle" },
			},
		},
		win = { border = "single" },
	},
}
