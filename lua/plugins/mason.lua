return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				--formatters
				"shfmt",
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
	opts = {
		ui = {
			border = "rounded",
		},
	},
}
