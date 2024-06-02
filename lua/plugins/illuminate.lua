return {
	"RRethy/vim-illuminate",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		providers = { "lsp" },
		large_file_cutoff = 1000,
		modes_denylist = { "v", "V" },
	},
	config = function(_, opts) require("illuminate").configure(opts) end,
}
