return {
	"echasnovski/mini.comment",
	version = false,
	dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		options = {
			custom_commentstring = function()
				return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
			end,
		},
	},
}
