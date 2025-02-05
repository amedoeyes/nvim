vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", {
	desc = "Down",
	expr = true,
	silent = true,
})
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", {
	desc = "Up",
	expr = true,
	silent = true,
})

vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", {
	desc = "Escape and clear hlsearch",
})
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", {
	desc = "Next search result",
	expr = true,
})
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", {
	desc = "Prev search result",
	expr = true,
})
vim.keymap.set({ "x", "o" }, "n", "'Nn'[v:searchforward]", {
	desc = "Next search result",
	expr = true,
})
vim.keymap.set({ "x", "o" }, "N", "'nN'[v:searchforward]", {
	desc = "Prev search result",
	expr = true,
})

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Normal mode" })

vim.keymap.set("n", "gK", function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = "Toggle diagnostic virtual_lines" })

vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "grlr", vim.lsp.codelens.run, { desc = "Codelens run" })
vim.keymap.set("n", "grlc", vim.lsp.codelens.clear, { desc = "Codelens clear" })
vim.keymap.set("n", "grlf", vim.lsp.codelens.refresh, { desc = "Codelens refresh" })
