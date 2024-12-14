return {
	"saghen/blink.cmp",
	version = "v0.*",
	dependencies = "rafamadriz/friendly-snippets",
	lazy = false,
	opts = {
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
			},
			providers = {
				lsp = { fallback_for = { "lazydev" } },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
			},
		},
		accept = {
			auto_brackets = { enabled = true },
		},
		completion = {
			menu = {
				border = "single",
			},
			documentation = {
				window = { border = "single" },
			},
			signature = {
				window = { border = "single" },
			},
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
