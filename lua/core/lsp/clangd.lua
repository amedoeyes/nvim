return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--suggest-missing-includes",
		"--header-insertion=iwyu",
	},
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
}
