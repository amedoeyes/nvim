return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		spec = {
			{
				mode = { "n", "v" },
				{ "]", group = "next" },
				{ "[", group = "prev" },
				{ "gr", group = "lsp" },
				{ "go", group = "operations" },
				{ "gs", group = "surround" },
				{ "<leader>T", group = "toggle" },
				{ "<leader>b", group = "buffers" },
				{ "<leader>d", group = "debugger" },
				{ "<leader>f", group = "files" },
				{ "<leader>g", group = "git" },
				{ "<leader>o", group = "tasks" },
				{ "<leader>t", group = "tests" },
			},
		},
		win = { border = "single" },
	},
}
