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

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", {
	desc = "Normal mode",
})

vim.keymap.set("i", "<C-S>", function()
	vim.lsp.buf.signature_help({ border = "single", max_width = 80 })
end, {
	desc = "Signature help",
})
vim.keymap.set("n", "grD", vim.lsp.buf.declaration, {
	desc = "Declaration",
})
vim.keymap.set("n", "gra", vim.lsp.buf.code_action, {
	desc = "Code actions",
})
vim.keymap.set("n", "grd", vim.lsp.buf.definition, {
	desc = "Definition",
})
vim.keymap.set("n", "gri", vim.lsp.buf.implementation, {
	desc = "Implementation",
})
vim.keymap.set("n", "grn", vim.lsp.buf.rename, {
	desc = "Rename",
})
vim.keymap.set("n", "grr", vim.lsp.buf.references, {
	desc = "References",
})
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, {
	desc = "Type definition",
})
vim.keymap.set("n", "grlr", vim.lsp.codelens.run, {
	desc = "Codelens run",
})
vim.keymap.set("n", "grlc", vim.lsp.codelens.clear, {
	desc = "Codelens clear",
})
vim.keymap.set("n", "grlf", vim.lsp.codelens.refresh, {
	desc = "Codelens refresh",
})
