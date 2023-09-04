return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"bashls",
				"black",
				"clangd",
				"cmake",
				"cmakelang",
				"codelldb",
				"cssls",
				"emmet_language_server",
				"eslint",
				"jsonls",
				"lua_ls",
				"marksman",
				"node-debug2-adapter",
				"prettier",
				"pyright",
				"ruff",
				"shfmt",
				"stylua",
				"tailwindcss",
				"tsserver",
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
