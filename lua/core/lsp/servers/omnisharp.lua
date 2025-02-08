return {
	cmd = {
		"omnisharp",
		"-z",
		"-hpid",
		tostring(vim.fn.getpid()),
		"DotNet:enablePackageRestore=false",
		"-lsp",
	},
	root_patterns = { "*.csproj" },
}
