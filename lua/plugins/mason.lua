return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"bash-language-server",
				"black",
				"clangd",
				"cmake-language-server",
				"cmakelang",
				"codelldb",
				"css-lsp",
				"emmet-language-server",
				"eslint-lsp",
				"flake8",
				"json-lsp",
				"lua-language-server",
				"marksman",
				"prettierd",
				"pyright",
				"shellcheck",
				"shfmt",
				"stylua",
				"tailwindcss-language-server",
				"typescript-language-server",
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
