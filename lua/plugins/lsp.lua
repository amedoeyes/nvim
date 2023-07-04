require("lspconfig.ui.windows").default_options.border = "rounded"

return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				"pyright",
				"flake8",
				"black",
				"markdownlint",
				"marksman",
			},
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function()
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.shfmt,
					nls.builtins.formatting.prettierd.with({
						extra_args = { "--tab-width 4", "--use-tabs" },
					}),
					nls.builtins.formatting.markdownlint,
					nls.builtins.formatting.black,

					nls.builtins.diagnostics.flake8.with({
						extra_args = { "--ignore", "E501" },
					}),
					nls.builtins.diagnostics.markdownlint.with({
						extra_args = { "--disable", "MD013", "MD033" },
					}),
				},
				border = "rounded",
			}
		end,
	},
}
