return {
	"folke/persistence.nvim",
	opts = {},
	keys = {
		{
			"<leader>qr",
			function()
				require("persistence").stop()
			end,
			desc = "Restore session",
		},
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore last session",
		},
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
			desc = "Don't save session",
		},
	},
}
