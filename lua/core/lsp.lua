vim.lsp.set_log_level("off")

vim.diagnostic.config({
	underline = true,
	update_in_insert = true,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	severity_sort = true,
	float = {
		style = "minimal",
		border = "rounded",
		header = "",
	},
})

local icons = require("core.icons")
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
			[vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
			[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
			[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
		},
	},
})
