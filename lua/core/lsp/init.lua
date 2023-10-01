local M = {}

M.config = {
	diagnostic = {
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
	},
	inlay_hint = false,
	autoformat = true,
}

M.format = function()
	local buffer = vim.api.nvim_get_current_buf()
	vim.lsp.buf.format({
		bufnr = buffer,
		filter = function(c)
			return c.name == "null-ls"
		end,
		timeout_ms = 5000,
	})
end

---@param on_attach function
M.on_attach = function(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(e)
			on_attach(vim.lsp.get_client_by_id(e.data.client_id), e.buf)
		end,
	})
end

M.setup = function()
	local icons = require("core.icons")
	vim.lsp.set_log_level("off")
	vim.diagnostic.config(M.config.diagnostic)

	for name, icon in pairs(icons.diagnostics) do
		name = "DiagnosticSign" .. name
		vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
	end
end

return M
