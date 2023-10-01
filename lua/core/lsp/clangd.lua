return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--fallback-style=google",
		"--function-arg-placeholders",
		"--header-insertion=iwyu",
		"--suggest-missing-includes",
	},
	capabilities = {
		offsetEncoding = { "utf-16" },
	},
}
