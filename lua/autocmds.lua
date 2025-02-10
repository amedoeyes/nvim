vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("eyes.terminal", { clear = true }),
	callback = function()
		vim.opt_local.statuscolumn = ""
		vim.cmd.startinsert()
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = vim.api.nvim_create_augroup("eyes.checktime", { clear = true }),
	command = "checktime",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("eyes.highlight_yank", { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("eyes.last_loc", { clear = true }),
	callback = function(e)
		vim.b[e.buf].last_loc = true
		local mark = vim.api.nvim_buf_get_mark(e.buf, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(e.buf) then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "VimEnter" }, {
	group = vim.api.nvim_create_augroup("git_branch", { clear = true }),
	callback = function()
		if vim.fs.root(0, ".git") then
			local cmd = vim.system({ "git", "branch", "--show-current" }):wait()
			if cmd.code == 0 then vim.g.git_branch = vim.trim(cmd.stdout) end
		end
	end,
})
