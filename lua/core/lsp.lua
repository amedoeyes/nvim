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

for name, icon in pairs(icons.diagnostics) do
	name = "DiagnosticSign" .. name
	vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end
