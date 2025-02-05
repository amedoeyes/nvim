return {
	"saghen/blink.cmp",
	version = "v0.*",
	dependencies = "rafamadriz/friendly-snippets",
	event = { "InsertEnter", "CmdlineEnter" },
	opts = {
		completion = {
			keyword = { range = "full" },
			list = {
				selection = {
					auto_insert = false,
				},
			},
			menu = { border = "single" },
			documentation = {
				window = { border = "single" },
			},
		},
		signature = {
			window = { border = "single" },
		},
		appearance = {
			kind_icons = {
				Class = "",
				Color = "",
				Constant = "",
				Constructor = "",
				Enum = "",
				EnumMember = "",
				Event = "",
				Field = "",
				File = "",
				Folder = "",
				Function = "",
				Interface = "",
				Keyword = "",
				Method = "",
				Module = "",
				Operator = "",
				Property = "",
				Reference = "",
				Snippet = "",
				Struct = "",
				Text = "",
				TypeParameter = "",
				Unit = "",
				Value = "󰎠",
				Variable = "",
			},
		},
	},
}
