return {
	"folke/noice.nvim",
	dependencies = {
		{ "MunifTanjim/nui.nvim", lazy = true },
	},
	lazy = false,
	opts = {
		views = {
			cmdline_popup = { border = { style = "single" } },
			cmdline_popupmenu = { border = { style = "single" } },
		},
		lsp = {
			progress = { enabled = false },
			hover = { enabled = false },
			signature = { enabled = false },
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
		},
	},
}
