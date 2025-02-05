return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
		linters_by_ft = {},
	},
	config = function(_, opts)
		require("lint").linters_by_ft = opts.linters_by_ft
		vim.api.nvim_create_autocmd(opts.events, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function() require("lint").try_lint() end,
		})
	end,
}
