return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
		{ "b0o/SchemaStore.nvim", version = false },
		"pmizio/typescript-tools.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local servers = {
			bashls = {
				filetypes = { "sh", "zsh" },
			},
			clangd = {},
			cmake = {},
			cssls = {},
			emmet_language_server = {},
			eslint = {
				settings = {
					workingDirectory = { mode = "auto" },
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
			marksman = {},
			pyright = {},
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
			tsserver = function()
				require("typescript-tools").setup({
					settings = {
						tsserver_path = vim.env.PNPM_HOME .. "/global/5/node_modules/typescript/lib/tsserver.js",
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
