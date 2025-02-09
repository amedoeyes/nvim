vim.lsp.set_log_level("off")

local original_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
	opts.border = "single"
	opts.max_width = 80
	return original_open_floating_preview(contents, syntax, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(e)
		local client = vim.lsp.get_client_by_id(e.data.client_id)
		if not client then return end
		if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("eyes.lsp.codelens", { clear = false }),
				buffer = e.buf,
				callback = function()
					if vim.g.codelens then vim.lsp.codelens.refresh({ bufnr = e.buf }) end
				end,
			})
		end
		if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
			vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

vim.lsp.config("*", { root_markers = { ".git" } })

vim.lsp.enable({
	"bash-language-server",
	"clangd",
	"glslls",
	"gopls",
	"haskell-language-server",
	"lua-language-server",
	"marksman",
	"omnisharp",
	"pylsp",
	"typescript-language-server",
	"vscode-css-language-server",
	"vscode-eslint-language-server",
	"vscode-html-language-server",
	"vscode-json-language-server",
	"zk",
})
