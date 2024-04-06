local util = require("core.util")
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime", { clear = true }),
	command = "checktime",
})

autocmd("TextYankPost", {
	group = augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("VimResized", {
	group = augroup("resize_splits", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

autocmd("BufReadPost", {
	group = augroup("cursor_to_mark", { clear = true }),
	callback = function(event)
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')

		pcall(vim.api.nvim_win_set_cursor, 0, mark)
	end,
})

autocmd("FileType", {
	group = augroup("close_with_q", { clear = true }),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
		"Clangd*",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

autocmd("FileType", {
	group = augroup("spell", { clear = true }),
	pattern = { "gitcommit", "markdown", "tex" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

autocmd("BufWritePre", {
	group = augroup("create_dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end

		local file = vim.loop.fs_realpath(event.match) or event.match

		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

autocmd("VimEnter", {
	group = augroup("cd_root", { clear = true }),
	callback = function()
		vim.cmd("cd " .. util.get_root_dir())
	end,
})
