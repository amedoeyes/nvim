return {
	"L3MON4D3/LuaSnip",
	version = "2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	event = "InsertEnter",
	opts = {
		region_check_events = "CursorMoved",
	},
	keys = {
		{
			"<Tab>",
			function()
				if require("luasnip").jumpable(1) then
					return "<Plug>luasnip-jump-next"
				end

				return "<tab>"
			end,
			mode = "i",
			desc = "Luasnip/Tab",
			expr = true,
			silent = true,
		},
		{
			"<Tab>",
			function()
				require("luasnip").jump(1)
			end,
			mode = "s",
			desc = "Next snippet",
		},
		{
			"<S-Tab>",
			function()
				require("luasnip").jump(-1)
			end,
			mode = { "i", "s" },
			desc = "Previous snippet",
		},
	},
}
