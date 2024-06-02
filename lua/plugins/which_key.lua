return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		show_help = false,
		defaults = {
			mode = { "n", "v" },
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
			["gr"] = { name = "+lsp" },
			["gs"] = { name = "+surround" },
			["<leader>b"] = { name = "+buffers" },
			["<leader>d"] = { name = "+debugger" },
			["<leader>f"] = { name = "+files" },
			["<leader>g"] = { name = "+git" },
			["<leader>gh"] = { name = "+hunks" },
			["<leader>o"] = { name = "+options" },
			["<leader>t"] = { name = "+terminal" },
		},
		window = { border = "rounded" },
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
