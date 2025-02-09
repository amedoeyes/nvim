vim.opt_local.statuscolumn = ""
vim.bo.buflisted = false

vim.keymap.set("n", "q", function()
	vim.cmd("close")
	pcall(vim.api.nvim_buf_delete, 0, { force = true })
end, { silent = true, buffer = 0, desc = "Quit buffer" })
