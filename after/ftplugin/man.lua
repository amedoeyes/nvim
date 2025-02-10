vim.opt_local.statuscolumn = ""
vim.bo.buflisted = false

vim.keymap.set("n", "q", function()
	if #vim.api.nvim_list_wins() == 1 then
		vim.cmd.quit()
	else
		vim.cmd.close()
	end
end, { silent = true, buffer = 0 })
