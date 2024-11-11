return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--fallback-style=llvm",
		"--function-arg-placeholders",
		"--header-insertion=iwyu",
		"--suggest-missing-includes",
		"--experimental-modules-support",
	},
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
		clangdFileStatus = true,
	},
}
