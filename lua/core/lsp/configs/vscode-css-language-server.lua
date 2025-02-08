return {
	cmd = { "vscode-css-language-server", "--stdio" },
	settings = {
		css = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
	root_patterns = { "package.json" },
}
