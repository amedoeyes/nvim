return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			codeLens = { enable = true },
			completion = {
				callSnippet = "Replace",
				keywordSnippet = "Both",
			},
			format = { enable = false },
			hint = { enable = true },
			window = {
				progressBar = false,
				statusBar = false,
			},
			workspace = {
				checkThirdParty = "Disable",
				userThirdParty = { "~/projects/programming/xmake-lls/" },
				library = {
					vim.env.VIMRUNTIME,
					require("mini.deps").config.path.package,
				},
			},
		},
	},
}
