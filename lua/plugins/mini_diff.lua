return {
	"echasnovski/mini.diff",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		view = {
			style = "sign",
			signs = {
				add = "▎",
				change = "▎",
				delete = "",
			},
		},
	},
	keys = {
		{
			"<leader>go",
			function()
				require("mini.diff").toggle_overlay(0)
			end,
			desc = "Toggle diff overlay",
		},
	},
}
