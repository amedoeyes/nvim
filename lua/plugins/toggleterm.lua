return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		float_opts = {
			border = "rounded",
		},
		highlights = {
			FloatBorder = {
				link = "FloatBorder",
			},
		},
	},
	config = true,
	keys = {
		{
			"<leader>gg",
			function()
				local Terminal = require("toggleterm.terminal").Terminal

				local lazygit = Terminal:new({
					cmd = "lazygit",
					direction = "float",
					dir = vim.fn.getcwd(),
				})

				lazygit:toggle()
			end,
			mode = { "n", "t" },
			desc = "LazyGit",
		},
		{
			"<leader>tt",
			function()
				require("toggleterm").toggle(1, 15, vim.fn.getcwd(), "horizontal")
			end,
			mode = { "n", "t" },
			desc = "Toggle terminal",
		},
		{
			"<leader>th",
			function()
				require("toggleterm").toggle(1, 15, vim.fn.getcwd(), "horizontal")
			end,
			mode = { "n", "t" },
			desc = "Open horizontal terminal",
		},
		{
			"<leader>tv",
			function()
				require("toggleterm").toggle(1, 75, vim.fn.getcwd(), "vertical")
			end,
			mode = { "n", "t" },
			desc = "Open vertical terminal",
		},
		{
			"<leader>tf",
			function()
				require("toggleterm").toggle(1, 0, vim.fn.getcwd(), "float")
			end,
			mode = { "n", "t" },
			desc = "Open floating terminal",
		},
	},
}
