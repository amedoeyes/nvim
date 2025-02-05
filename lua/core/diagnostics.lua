local icons = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.INFO] = " ",
	[vim.diagnostic.severity.HINT] = " ",
}

vim.diagnostic.config({
	virtual_text = {
		source = false,
		prefix = function(d) return icons[d.severity] end,
	},
	signs = { text = icons },
	float = {
		header = "",
		border = "single",
	},
	severity_sort = true,
})
