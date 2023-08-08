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

autocmd({ "VimResized" }, {
	group = augroup("resize_splits", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

autocmd("BufReadPost", {
	group = augroup("cursor_to_mark", { clear = true }),
	callback = function(event)
		local mark = vim.api.nvim_buf_get_mark(event.buf, '"')

		vim.api.nvim_win_set_cursor(0, mark)
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
	group = augroup("wrap_spell", { clear = true }),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

autocmd("BufWritePre", {
	group = augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end

		local file = vim.loop.fs_realpath(event.match) or event.match

		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

vim.api.nvim_create_autocmd("TermClose", {
	group = augroup("lazygit_close", { clear = true }),
	pattern = "*lazygit*",
	callback = function()
		if package.loaded["neo-tree.sources.git_status"] then
			require("neo-tree.sources.git_status").refresh()
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
	group = augroup("cd_to_project_root", { clear = true }),
	callback = function()
		pcall(function()
			vim.cmd("lcd %:p:h")
		end)
		vim.cmd("ProjectRoot")
	end,
})

local lsp = require("config.lsp")

lsp.on_attach(function(_, buffer)
	local lsp_augroup = augroup("lsp_on_attach", { clear = false })

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = lsp_augroup,
		buffer = buffer,
		callback = function()
			if lsp.config.autoformat then
				lsp.format()
			end
		end,
	})

	vim.api.nvim_create_autocmd("BufEnter", {
		group = lsp_augroup,
		buffer = buffer,
		callback = function()
			vim.lsp.inlay_hint(0, lsp.config.inlay_hint)
		end,
	})
end)
