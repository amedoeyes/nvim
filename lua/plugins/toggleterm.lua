return {
	"akinsho/toggleterm.nvim",
	cmd = "ToggleTerm",
	opts = {
		float_opts = { border = "rounded" },
		highlights = {
			FloatBorder = { link = "FloatBorder" },
		},
	},
	keys = {
		{
			"<leader>gg",
			function()
				require("toggleterm.terminal").Terminal
					:new({
						cmd = "lazygit",
						count = 2,
						direction = "float",
						dir = vim.fn.getcwd(),
						display_name = "LazyGit",
					})
					:toggle()
			end,
			mode = { "n", "t" },
			desc = "LazyGit",
		},
		{
			"<leader>tt",
			function() require("toggleterm").toggle(1, 10, vim.fn.getcwd(), "horizontal") end,
			mode = { "n", "t" },
			desc = "Horizontal terminal",
		},
		{
			"<leader>tv",
			function() require("toggleterm").toggle(1, 80, vim.fn.getcwd(), "vertical") end,
			mode = { "n", "t" },
			desc = "Vertical terminal",
		},
		{
			"<leader>tf",
			function() require("toggleterm").toggle(1, 0, vim.fn.getcwd(), "float") end,
			mode = { "n", "t" },
			desc = "Floating terminal",
		},
	},
}
