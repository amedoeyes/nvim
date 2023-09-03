return {
	"stevearc/dressing.nvim",
	event = "VimEnter",
	opts = {
		input = {
			win_options = {
				winblend = 0,
			},
		},
		select = {
			win_options = {
				winblend = 0,
			},
			nui = {
				win_options = {
					winblend = 0,
				},
			},
		},
	},
}
