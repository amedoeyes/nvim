return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		indent = { char = "│", tab_char = "│" },
		scope = { show_start = false, show_end = false },
	},
}
