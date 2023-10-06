return {
	"sourcegraph/sg.nvim",
	enabled = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	opts = {
		accept_tos = true,
	},
	keys = {
		{
			"<leader>cc",
			"<CMD>CodyToggle<CR>",
			desc = "Cody",
		},
	},
}
