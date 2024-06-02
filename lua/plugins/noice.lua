return {
	"folke/noice.nvim",
	dependencies = {
		{ "MunifTanjim/nui.nvim", lazy = true },
		{
			"rcarriga/nvim-notify",
			opts = {
				stages = "slide",
				render = "wrapped-compact",
				timeout = 3000,
				max_height = function() return math.floor(vim.o.lines * 0.75) end,
				max_width = function() return math.floor(vim.o.columns * 0.75) end,
			},
		},
	},
	event = "VeryLazy",
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			progress = { enabled = false },
			hover = { silent = true },
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = true,
			lsp_doc_border = true,
		},
	},
}
