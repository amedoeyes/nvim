return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
		{ "b0o/SchemaStore.nvim", version = false },
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
			eslint = {},
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
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
			tsserver = {},
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
