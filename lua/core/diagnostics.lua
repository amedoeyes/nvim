local diagnostic = vim.diagnostic

local icons = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.INFO] = " ",
	[vim.diagnostic.severity.HINT] = " ",
}

diagnostic.config({
	underline = true,
	update_in_insert = true,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = function(d) return icons[d.severity] end,
	},
	severity_sort = true,
	float = {
		style = "minimal",
		border = "rounded",
		header = "",
	},
	signs = {
		text = icons,
	},
})
