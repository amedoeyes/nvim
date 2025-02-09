vim.lsp.set_log_level("off")

local original_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.open_floating_preview = function(contents, syntax, opts)
	opts.border = "single"
	opts.max_width = 80
	return original_open_floating_preview(contents, syntax, opts)
end

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
	"vscode-html-language-server",
	"vscode-json-language-server",
	"zk",
})
