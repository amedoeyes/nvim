return {
	"RRethy/vim-illuminate",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		providers = { "lsp" },
		modes_denylist = { "v", "V" },
	},
	config = function(_, opts)
		require("illuminate").configure(opts)
	end,
	keys = {
		{
			"]r",
			function()
				require("illuminate").goto_next_reference()
			end,
			desc = "Next reference",
		},
		{
			"[r",
			function()
				require("illuminate").goto_prev_reference()
			end,
			desc = "Previous reference",
		},
	},
}
