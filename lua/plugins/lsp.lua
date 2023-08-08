return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "folke/neodev.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "b0o/SchemaStore.nvim", version = false },
			"p00f/clangd_extensions.nvim",
			{
				"pmizio/typescript-tools.nvim",
				dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
				opts = {},
			},
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local servers = {
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
				tailwindcss = {},
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

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
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

			require("config.lsp").setup()
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"mason.nvim",
			"nvim-lua/plenary.nvim",
			{ "ThePrimeagen/refactoring.nvim", opts = {} },
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local nls = require("null-ls")
			local filetypes_exclude = function(exclude, filetypes)
				return vim.tbl_filter(function(ft)
					return not vim.tbl_contains(exclude, ft)
				end, filetypes)
			end

			return {
				sources = {
					--formatters
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.prettierd.with({
						extra_args = { "--tab-width=4", "--use-tabs" },
						filetypes = filetypes_exclude(
							{ "markdown" },
							require("null-ls.builtins._meta.formatting").prettierd.filetypes
						),
					}),
					nls.builtins.formatting.markdownlint,
					nls.builtins.formatting.black,

					--linters
					nls.builtins.diagnostics.flake8.with({
						extra_args = { "--ignore", "E501" },
					}),
					nls.builtins.diagnostics.markdownlint.with({
						extra_args = { "--disable", "MD013", "MD033" },
					}),

					--code_actions
					nls.builtins.code_actions.refactoring,
				},
				border = "rounded",
				update_in_insert = true,
			}
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = {
					ensure_installed = {
						--formatters
						"stylua",
						"prettierd",
						"black",
						--linters
						"flake8",
						"markdownlint",
					},
				},
			},
		},
		build = ":MasonUpdate",
		cmd = "Mason",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
}
