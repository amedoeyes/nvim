return {
	"folke/flash.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		prompt = { enabled = false },
	},
	keys = {
		{
			"s",
			function()
				require("flash").jump()
			end,
			desc = "Flash jump",
		},
		{
			"S",
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
}
