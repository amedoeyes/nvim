return {
	{
		"jcdickinson/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		commit = "b1ff0d6c993e3d87a4362d2ccd6c660f7444599f",
		config = true,
	},
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
