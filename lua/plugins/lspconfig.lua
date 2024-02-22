return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "folke/neodev.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
		{ "b0o/SchemaStore.nvim", version = false, lazy = true },
		"williamboman/mason-lspconfig.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("mason-lspconfig").setup()

		local lspconfig = require("lspconfig")
		for server, opts in pairs(require("language_servers")) do
			opts.capabilities = vim.tbl_deep_extend(
				"force",
				{},
				require("cmp_nvim_lsp").default_capabilities() or {},
				opts.capabilities or {}
			)
			lspconfig[server].setup(opts)
		end

		require("lspconfig.ui.windows").default_options.border = "rounded"
	end,
}
