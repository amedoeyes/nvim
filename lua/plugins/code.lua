return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		cmd = { "TSUpdateSync" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"comment",
				"html",
				"javascript",
				"json",
				"json5",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "2.*",
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		opts = {
			region_check_events = "CursorMoved",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
			"onsails/lspkind.nvim",
			"lukas-reineke/cmp-under-comparator",
		},
		opts = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local icons = require("config.util").icons

			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 20,
						ellipsis_char = "…",
						symbol_map = icons.kinds,
						before = function(entry, item)
							require("tailwindcss-colorizer-cmp").formatter(entry, item)

							return item
						end,
					}),
				},
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						require("cmp-under-comparator").under,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				window = {
					completion = cmp.config.window.bordered({
						winhighlight = "FloatBorder:FloatBorder",
					}),
					documentation = cmp.config.window.bordered({
						winhighlight = "FloatBorder:FloatBorder",
					}),
				},
			}
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"echasnovski/mini.surround",
		event = "BufReadPre",
		opts = {
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
				update_n_lines = "gsn",
				suffix_next = "]",
				suffix_last = "[",
			},
		},
	},
	{
		"echasnovski/mini.comment",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		event = "BufReadPre",
		opts = {
			options = {
				custom_commentstring = function()
					---@diagnostic disable-next-line: missing-parameter
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},
	{
		"echasnovski/mini.move",
		event = "BufReadPre",
		opts = {},
	},
	{
		"Exafunction/codeium.vim",
		config = function()
			vim.g.codeium_no_map_tab = true
			vim.g.codeium_enabled = true
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		opts = {},
	},
	{
		"ThePrimeagen/refactoring.nvim",
		opts = {},
	},
}
