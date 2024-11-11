return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter", lazy = true },
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	ft = { "markdown" },
	opts = {
		render_modes = true,
		heading = {
			icons = {
				"█ ",
				"██ ",
				"███ ",
				"████ ",
				"█████ ",
				"██████ ",
			},
		},
		code = {
			style = "full",
			position = "right",
			disable_background = {},
			width = "block",
			left_pad = 2,
			right_pad = 2,
			min_width = 80,
			border = "thick",
		},
		quote = { repeat_linebreak = true },
		sign = { enabled = false },
		overrides = {
			buftype = {
				nofile = {
					heading = {
						position = "inline",
						icons = { "█", "█", "█", "█", "█", "█" },
						backgrounds = {},
					},
					code = { style = "none" },
				},
			},
		},
	},
}
