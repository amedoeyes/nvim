return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		show_help = false,
		defaults = {
			mode = { "n", "v" },
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
			["gs"] = { name = "+surround" },
			["<leader>b"] = { name = "+buffers" },
			["<leader>c"] = { name = "+code" },
			["<leader>d"] = { name = "+debug" },
			["<leader>f"] = { name = "+files" },
			["<leader>g"] = { name = "+git" },
			["<leader>o"] = { name = "+options" },
			["<leader>t"] = { name = "+terminal" },
		},
		window = {
			border = "rounded",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
