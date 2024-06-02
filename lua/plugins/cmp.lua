return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",
		"lukas-reineke/cmp-under-comparator",
		{ "zbirenbaum/copilot-cmp", opts = {} },
		{
			"garymjr/nvim-snippets",
			dependencies = "rafamadriz/friendly-snippets",
			opts = {
				friendly_snippets = true,
			},
		},
	},
	event = "InsertEnter",
	opts = function()
		local cmp = require("cmp")
		return {
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			snippet = {
				expand = function(args) vim.snippet.expand(args.body) end,
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			formatting = {
				format = require("lspkind").cmp_format({
					maxwidth = 30,
					ellipsis_char = "…",
					symbol_map = {
						Class = "",
						Color = "",
						Constant = "",
						Constructor = "",
						Copilot = "",
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
					before = function(_, item)
						item.menu = nil
						return item
					end,
				}),
			},
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" },
				{ name = "snippets" },
				{ name = "path" },
				{ name = "buffer" },
			}),
			window = {
				completion = cmp.config.window.bordered({ winhighlight = "FloatBorder:FloatBorder" }),
				documentation = cmp.config.window.bordered({ winhighlight = "FloatBorder:FloatBorder" }),
			},
		}
	end,
	keys = {
		{
			"<Tab>",
			function()
				if vim.snippet.active({ direction = 1 }) then
					vim.schedule(function() vim.snippet.jump(1) end)
					return
				end
				return "<Tab>"
			end,
			expr = true,
			silent = true,
			mode = "i",
		},
		{
			"<Tab>",
			function()
				vim.schedule(function() vim.snippet.jump(1) end)
			end,
			expr = true,
			silent = true,
			mode = "s",
		},
		{
			"<S-Tab>",
			function()
				if vim.snippet.active({ direction = -1 }) then
					vim.schedule(function() vim.snippet.jump(-1) end)
					return
				end
				return "<S-Tab>"
			end,
			expr = true,
			silent = true,
			mode = { "i", "s" },
		},
	},
}
