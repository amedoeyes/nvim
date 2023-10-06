return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
		{ "b0o/SchemaStore.nvim", version = false },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local servers = {
			bashls = require("core.lsp.bashls"),
			clangd = require("core.lsp.clangd"),
			cmake = {},
			cssls = {},
			emmet_language_server = {},
			eslint = {},
			jsonls = require("core.lsp.jsonls"),
			lua_ls = require("core.lsp.lua_ls"),
			marksman = {},
			pyright = {},
			tailwindcss = require("core.lsp.tailwindcss"),
			tsserver = {},
		}

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		for server, opts in pairs(servers) do
			opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, opts)

			require("lspconfig")[server].setup(opts)
		end

		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
}
