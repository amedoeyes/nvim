vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("terminal", { clear = true }),
	callback = function() vim.cmd("startinsert") end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = vim.api.nvim_create_augroup("checktime", { clear = true }),
	callback = function()
		if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
	callback = function(e)
		local exclude = { "gitcommit" }
		local buf = e.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then return end
		vim.b[buf].last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("disable_columns", { clear = true }),
	pattern = { "man", "help" },
	callback = function()
		vim.opt_local.statuscolumn = ""
		vim.opt_local.signcolumn = "no"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = {
		"checkhealth",
		"grug-far",
		"help",
		"qf",
	},
	callback = function(e)
		vim.bo[e.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, e.buf, { force = true })
			end, {
				buffer = e.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("read_exrc", { clear = true }),
	callback = function()
		if vim.o.exrc == false then return end
		local exrcs = { ".nvim.lua", ".nvimrc", ".exrc" }
		local root = vim.fs.root(0, exrcs)
		if not root then return end
		for _, exrc in ipairs(exrcs) do
			local filepath = root .. "/" .. exrc
			if vim.uv.fs_stat(filepath) then
				if vim.secure.read(filepath) then vim.cmd.source(filepath) end
			end
		end
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermLeave", "VimEnter" }, {
	group = vim.api.nvim_create_augroup("git_branch", { clear = true }),
	callback = function()
		if vim.fs.root(0, ".git") then
			local cmd = vim.system({ "git", "branch", "--show-current" }):wait()
			if cmd.code == 0 then vim.g.git_branch = vim.trim(cmd.stdout) end
		end
	end,
})
