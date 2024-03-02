local util = require("core.util")
local map = vim.keymap.set

--Code

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

--LSP

util.lsp_on_attach(function(_, buffer)
	--Code

	map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = buffer })
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Actions", buffer = buffer })

	--Diagnostics

	map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostic", buffer = buffer })

	--Documentation

	map("n", "K", vim.lsp.buf.hover, { desc = "Documentation", buffer = buffer })

	--Go to

	map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = buffer })
	map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = buffer })
	map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = buffer })
	map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition", buffer = buffer })

	--Options

	map("n", "<leader>of", function()
		vim.g.autoformat = not vim.g.autoformat
		util.toggle_notify("Autoformat", vim.g.autoformat)
	end, { desc = "Toggle autoformat", buffer = buffer })

	map("n", "<leader>oi", function()
		vim.g.inlayhint = not vim.g.inlayhint
		vim.lsp.inlay_hint.enable(0, vim.g.inlayhint)
		util.toggle_notify("Inlay hint", vim.g.inlayhint)
	end, { desc = "Toggle inlay hint", buffer = buffer })
end)

--Movement

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Next line", expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Previous line", expr = true, silent = true })

--Options

map("n", "<leader>os", function()
	vim.o.spell = not vim.o.spell
	util.toggle_notify("Spell", vim.o.spell)
end, { desc = "Toggle spell" })

--Search

map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Previous search result" })

--Terminal

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter normal mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

--Windows

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
