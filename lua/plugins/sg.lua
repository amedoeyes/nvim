return {
	"sourcegraph/sg.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
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
