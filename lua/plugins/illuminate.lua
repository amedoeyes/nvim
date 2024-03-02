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
}
