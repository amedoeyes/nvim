return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
		{ "b0o/SchemaStore.nvim", version = false },
		"p00f/clangd_extensions.nvim",
		"pmizio/typescript-tools.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local servers = {
			bashls = {
				filetypes = { "sh", "zsh" },
			},
			lua_ls = {
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
						},
						telemetry = { enable = false },
					},
				},
			},
			jsonls = {
				on_new_config = function(new_config)
					new_config.settings.json.schemas = new_config.settings.json.schemas or {}
					vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
				end,
				settings = {
					json = {
						format = {
							enable = true,
						},
						validate = { enable = true },
					},
				},
			},
			eslint = {
				settings = {
					workingDirectory = { mode = "auto" },
				},
			},
			tsserver = function()
				require("typescript-tools").setup({})
			end,
			cssls = {},
			tailwindcss = {
				root_dir = function(fname)
					return require("lspconfig").util.root_pattern(
						"tailwind.config.js",
						"tailwind.config.cjs",
						"tailwind.config.mjs",
						"tailwind.config.ts"
					)(fname)
				end,
			},
			emmet_language_server = {},
			marksman = {},
			pyright = {},
			clangd = function()
				require("clangd_extensions").setup({
					extensions = {
						ast = {
							role_icons = {
								type = "",
								declaration = "",
								expression = "",
								specifier = "",
								statement = "",
								["template argument"] = "",
							},
							kind_icons = {
								Compound = "",
								Recovery = "",
								TranslationUnit = "",
								PackExpansion = "",
								TemplateTypeParm = "",
								TemplateTemplateParm = "",
								TemplateParamObject = "",
							},
						},
						memory_usage = {
							border = "rounded",
						},
						symbol_info = {
							border = "rounded",
						},
					},
				})
			end,
		}

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
		})

		mason_lspconfig.setup_handlers({
			function(server)
				if type(servers[server]) == "function" then
					servers[server]()
					return
				end

				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = capabilities,
				}, servers[server] or {})

				require("lspconfig")[server].setup(server_opts)
			end,
		})

		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
}
