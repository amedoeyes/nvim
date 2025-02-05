vim.lsp.set_log_level("off")

local original_open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
	opts.border = "single"
	opts.max_width = 80
	return original_open_floating_preview(contents, syntax, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
	callback = function(e)
		local client = vim.lsp.get_client_by_id(e.data.client_id)
		if client then
			if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
				vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
					group = vim.api.nvim_create_augroup("lsp_codelens", { clear = true }),
					buffer = e.buf,
					callback = function()
						if vim.g.codelens then vim.lsp.codelens.refresh({ bufnr = e.buf }) end
					end,
				})
			end
		end
	end,
})
