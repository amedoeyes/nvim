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
	autoformat = true,
	inlay_hint = false,
}

M.toggle = {
	autoformat = function()
		M.config.autoformat = not M.config.autoformat
	end,
	inlay_hint = function()
		M.config.inlay_hint = not M.config.inlay_hint
		vim.lsp.inlay_hint(0, M.config.inlay_hint)
	end,
}

M.format = function()
	local buffer = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients()
	local filetype = vim.bo[buffer].filetype
	local formatters = require("null-ls.sources").get_available(filetype, "NULL_LS_FORMATTING")
	local client_ids = {}

	for _, client in pairs(clients) do
		if
			client.supports_method("textDocument/formatting")
			or client.supports_method("textDocument/rangeFormatting")
		then
			if #formatters > 0 and client.name == "null-ls" then
				table.insert(client_ids, client.id)
			end

			if #formatters == 0 and client.name ~= "null-ls" then
				table.insert(client_ids, client.id)
			end
		end
	end

	vim.lsp.buf.format({
		bufnr = vim.api.nvim_get_current_buf(),
		filter = function(c)
			return vim.tbl_contains(client_ids, c.id)
		end,
	})
end

M.on_attach = function(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(event)
			on_attach(vim.lsp.get_client_by_id(event.data.client_id), event.buf)
		end,
	})
end

M.setup = function()
	vim.diagnostic.config(M.config.diagnostic)

	for name, icon in pairs(require("config.icons").diagnostics) do
		name = "DiagnosticSign" .. name
		vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
	end
end

return M
