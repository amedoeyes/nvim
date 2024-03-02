return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"arduino_language_server",
				"asm-lsp",
				"asmfmt",
				"bash-language-server",
				"black",
				"clangd",
				"cmake-language-server",
				"codelldb",
				"css-lsp",
				"emmet-language-server",
				"eslint-lsp",
				"gersemi",
				"glsl_analyzer",
				"json-lsp",
				"lua-language-server",
				"marksman",
				"prettierd",
				"pylsp",
				"shellcheck",
				"shfmt",
				"stylua",
				"tailwindcss-language-server",
				"typescript-language-server",
			},
			auto_update = false,
		},
	},
}
