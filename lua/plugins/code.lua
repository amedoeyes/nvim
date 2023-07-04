local cmp = require("cmp")
return {
	"hrsh7th/nvim-cmp",
	opts = {
		sources = cmp.config.sources({
			{ name = "codeium" },
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
		}),
		formatting = {
			format = function(entry, item)
				local icons = require("lazyvim.config").icons.kinds

				if icons[item.kind] then
					item.kind = icons[item.kind] .. item.kind
				end

				if item.kind == "Codeium" then
					item.kind = " " .. item.kind
				end

				require("tailwindcss-colorizer-cmp").formatter(entry, item)

				return item
			end,
		},
		window = {
			completion = cmp.config.window.bordered({
				winhighlight = "Normal:Pmenu,Float:Pmenu,Search:None",
			}),
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:Pmenu,Float:Pmenu,Search:None",
			}),
		},
	},
}
