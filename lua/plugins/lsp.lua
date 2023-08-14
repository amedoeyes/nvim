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
			"pmizio/typescript-tools.nvim",
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
				cssls = {},
				tailwindcss = {},
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
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local icons = require("config.util").icons

			for name, sign in pairs(icons.dap) do
				vim.fn.sign_define("Dap" .. name, { text = sign })
			end
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		opts = {},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local nls = require("null-ls")

			return {
				sources = {
					nls.builtins.code_actions.refactoring,
				},
				border = "rounded",
				update_in_insert = true,
			}
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = "Mason",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
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

				--DAP
				"codelldb",
				"node-debug2-adapter",
			},
			auto_update = true,
		},
	},
	{
		"jayp0521/mason-null-ls.nvim",
		opts = {
			automatic_installation = true,
			handlers = {},
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			automatic_installation = true,
			handlers = {},
		},
	},
}
