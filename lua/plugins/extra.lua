return {

	{ "Exafunction/codeium.vim" },
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{
				"<C-/>",
				function()
					require("toggleterm").toggle(1, 15, vim.fn.getcwd())
				end,
				desc = "Toggle terminal",
			},
		},
		opts = {
			direction = "horizontal",
		},
	},
}
