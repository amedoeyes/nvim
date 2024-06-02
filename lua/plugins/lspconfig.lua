return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
		{ "b0o/SchemaStore.nvim", lazy = true },
		{
			"williamboman/mason-lspconfig.nvim",
			dependencies = "williamboman/mason.nvim",
			opts = {
				handlers = {
					function(server_name)
						local ok, server_opts = pcall(require, "language_servers." .. server_name)
						require("lspconfig")[server_name].setup(ok and server_opts or {})
					end,
				},
			},
		},
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function() require("lspconfig.ui.windows").default_options.border = "rounded" end,
}
