return {

	{ "Exafunction/codeium.vim" },
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{
				"<C-/>",
				function()
					require("toggleterm").toggle(1, 10, vim.fn.getcwd())
				end,
				desc = "Toggle terminal",
			},
		},
		opts = {
			direction = "horizontal",
		},
	},
}
