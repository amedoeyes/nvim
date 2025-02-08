return {
	cmd = { "vscode-json-language-server", "--stdio" },
	settings = {
		json = {
			format = { enable = false },
			validate = { enable = true },
		},
	},
}
