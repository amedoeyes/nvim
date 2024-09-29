local map = vim.keymap.set
local utils = require("core.utils")

map("n", "<leader>of", function() utils.toggle_global("autoformat") end, { desc = "Toggle autoformat" })
map("n", "<leader>os", function() utils.toggle_option("spell") end, { desc = "Toggle spell" })
map(
	"n",
	"<leader>od",
	function() vim.diagnostic.enable(utils.toggle_global("diagnostics")) end,
	{ desc = "Toggle diagnostics" }
)
map("n", "<leader>op", function() utils.toggle_global("minipairs_disable") end, { desc = "Toggle minipairs_disable" })
utils.lsp.on_supports_method("textDocument/inlayHint", function(_, _)
	map(
		"n",
		"<leader>oi",
		function() vim.lsp.inlay_hint.enable(utils.toggle_global("inlay_hints")) end,
		{ desc = "Toggle inlay_hints" }
	)
end)
utils.lsp.on_supports_method("textDocument/codeLens", function(_, _)
	map("n", "<leader>oc", function()
		if utils.toggle_global("codelens") then
			vim.lsp.codelens.refresh()
		else
			vim.lsp.codelens.clear()
		end
	end, { desc = "Toggle codelens" })
end)

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

map({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

map({ "n", "t" }, "<C-left>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
map({ "n", "t" }, "<C-down>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map({ "n", "t" }, "<C-up>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map({ "n", "t" }, "<C-right>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to previous buffer" })

map("n", "grD", vim.lsp.buf.declaration, { desc = "Declaration" })
map("n", "gra", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "grd", vim.lsp.buf.definition, { desc = "Definition" })
map("n", "grf", vim.lsp.buf.format, { desc = "Format" })
map("n", "gri", vim.lsp.buf.implementation, { desc = "Implementation" })
map("n", "grn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "grr", vim.lsp.buf.references, { desc = "References" })
map("n", "grt", vim.lsp.buf.type_definition, { desc = "Type definition" })

map("n", "grlr", vim.lsp.codelens.run, { desc = "Codelens run" })
map("n", "grlc", vim.lsp.codelens.clear, { desc = "Codelens clear" })
map("n", "grlf", vim.lsp.codelens.refresh, { desc = "Codelens refresh" })
