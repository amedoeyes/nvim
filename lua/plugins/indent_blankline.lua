return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		show_current_context = true,
		show_trailing_blankline_indent = false,
		-- use_treesitter = true,
		-- use_treesitter_scope = true,
	},
}
