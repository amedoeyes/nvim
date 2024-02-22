return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--cross-file-rename",
		"--fallback-style=google",
		"--function-arg-placeholders",
		"--header-insertion=iwyu",
		"--suggest-missing-includes",
	},
}
