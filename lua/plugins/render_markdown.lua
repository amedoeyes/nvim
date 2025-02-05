return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", lazy = true },
	ft = { "markdown" },
	opts = {
		render_modes = true,
		anti_conceal = {
			ignore = {
				bullet = { "n" },
				callout = { "n" },
				check_icon = { "n" },
				check_scope = { "n" },
				code_background = true,
				code_border = { "n" },
				code_language = { "n" },
				dash = { "n" },
				head_background = true,
				head_border = { "n" },
				head_icon = { "n" },
				link = { "n" },
				quote = { "n" },
				table_border = { "n" },
			},
		},
		heading = {
			icons = {
				"█ ",
				"██ ",
				"███ ",
				"████ ",
				"█████ ",
				"██████ ",
			},
			border = true,
			border_virtual = true,
			border_prefix = true,
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
			highlight_language = "Comment",
		},
		sign = { enabled = false },
		overrides = {
			buftype = {
				nofile = {
					heading = {
						position = "inline",
						border = false,
						border_virtual = false,
						border_prefix = false,
						backgrounds = {},
					},
					code = { style = "none" },
				},
			},
		},
		win_options = {
			conceallevel = { rendered = 2 },
			concealcursor = { rendered = "nc" },
		},
	},
}
