local autocmd = function(event, group, opts)
	opts = opts or {}
	opts.group = vim.api.nvim_create_augroup(group, { clear = true })
	return vim.api.nvim_create_autocmd(event, opts)
end
local utils = require("core.utils")

autocmd({ "FocusGained", "TermClose", "TermLeave" }, "checktime", {
	command = "checktime",
})

autocmd("TextYankPost", "highlight_yank", {
	callback = function() vim.highlight.on_yank() end,
})

autocmd("VimResized", "resize_splits", {
	callback = function() vim.cmd("tabdo wincmd =") end,
})

autocmd("FileType", "close_with_q", {
	pattern = {
		"checkhealth",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
	},
	callback = function(e)
		vim.bo[e.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = e.buf, silent = true })
	end,
})

utils.lsp.on_supports_method("textDocument/codeLens", function(_, buffer)
	autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, "lsp_codelens", {
		buffer = buffer,
		callback = function()
			if vim.g.codelens then vim.lsp.codelens.refresh({ bufnr = buffer }) end
		end,
	})
end)
