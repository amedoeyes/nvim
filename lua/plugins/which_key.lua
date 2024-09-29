return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		triggers = {
			{ "<auto>", mode = { "n", "v" } },
		},
		spec = {
			{
				mode = { "n", "v" },
				{ "]", group = "next" },
				{ "[", group = "prev" },
				{ "gr", group = "lsp" },
				{ "gs", group = "surround" },
				{ "<leader>b", group = "buffers" },
				{ "<leader>d", group = "debugger" },
				{ "<leader>f", group = "files" },
				{ "<leader>g", group = "git" },
				{ "<leader>gh", group = "hunks" },
				{ "<leader>o", group = "options" },
				{ "<leader>t", group = "terminal" },
			},
		},
	},
}
