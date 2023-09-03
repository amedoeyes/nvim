return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"black",
				"cmakelang",
				"codelldb",
				"ruff",
				"stylua",
				"node-debug2-adapter",
				"prettierd",
				"shfmt",
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
