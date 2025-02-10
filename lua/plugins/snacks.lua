local deps = require("mini.deps")

deps.now(function()
	Snacks.setup({
		bigfile = { enabled = true },
		indent = { enabled = true },
		notifier = {
			enabled = true,
			style = function(buf, notif, ctx)
				local lines = vim.split(notif.icon .. " " .. notif.msg, "\n")
				ctx.opts.wo.winhighlight = ""
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
			end,
			width = { max = 80 },
			top_down = false,
		},
		picker = {
			layouts = {
				default = {
					layout = {
						box = "horizontal",
						width = 0.8,
						min_width = 120,
						height = 0.8,
						{
							box = "vertical",
							border = "single",
							title = "{source} {live}",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list" },
						},
						{ win = "preview", title = "{preview}", border = "single", width = 0.5 },
					},
				},
				vertical = { layout = { border = "single" } },
				select = { layout = { border = "single" } },
			},
			ui_select = true,
			win = {
				input = {
					keys = {
						["<c-y>"] = { "confirm", mode = { "n", "i" } },
					},
				},
			},
		},
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true, debounce = 100 },
		styles = {
			blame_line = { border = "single" },
			input = { relative = "cursor", width = 25, row = -3, border = "single", title_pos = "left" },
			lazygit = { border = "single" },
			notification = { border = "single", wo = { winblend = 0 } },
			terminal = { border = "single", wo = { winbar = "" } },
			zen = { backdrop = { transparent = false } },
		},
	})

	Snacks.toggle.option("spell", { name = "Spell", global = true })
	Snacks.toggle.option("wrap", { global = true })
	Snacks.toggle.option("number", { global = true })
	Snacks.toggle.option("relativenumber", { global = true })
	Snacks.toggle.option("cursorline", { global = true })
	Snacks.toggle.option("showtabline", { on = vim.opt.showtabline:get(), off = 0, global = true })
	Snacks.toggle.option("laststatus", { on = vim.opt.laststatus:get(), off = 0, global = true })
	Snacks.toggle.option("statuscolumn", { on = vim.opt.statuscolumn:get(), off = "", global = true })
	Snacks.toggle.option("signcolumn", { on = vim.opt.signcolumn:get(), off = "no", global = true })

	Snacks.toggle.new({
		name = "Auto-Pairs",
		get = function() return not vim.g.minipairs_disable end,
		set = function(state) vim.g.minipairs_disable = not state end,
	})
	Snacks.toggle.new({
		name = "Auto-Format",
		get = function() return vim.g.autoformat end,
		set = function(state) vim.g.autoformat = state end,
	})
	Snacks.toggle.new({
		name = "Codelens",
		get = function() return vim.g.codelens end,
		set = function(state)
			vim.g.codelens = state
			if state then
				vim.lsp.codelens.refresh()
			else
				vim.lsp.codelens.clear()
			end
		end,
	})
	Snacks.toggle.new({
		id = "writemode",
		name = "Write mode",
		get = function() return vim.g.writemode end,
		set = function(state)
			if state then
				Snacks.toggle.get("spell"):set(true)
				Snacks.toggle.get("wrap"):set(true)
				Snacks.toggle.get("number"):set(false)
				Snacks.toggle.get("relativenumber"):set(false)
				Snacks.toggle.get("statuscolumn"):set(false)
				Snacks.toggle.get("signcolumn"):set(false)
				Snacks.toggle.get("indent"):set(false)
				vim.g.writemodebuf = vim.api.nvim_create_buf(false, true)
				vim.api.nvim_buf_set_name(vim.g.writemodebuf, "padding")
				local lwin = vim.api.nvim_open_win(vim.g.writemodebuf, false, {
					split = "left",
					focusable = false,
					style = "minimal",
				})
				local rwin = vim.api.nvim_open_win(vim.g.writemodebuf, false, {
					split = "right",
					focusable = false,
					style = "minimal",
				})
				local set_width = function()
					local width = math.floor((vim.o.columns - vim.o.textwidth - 80) / 2)
					vim.api.nvim_win_set_width(lwin, width)
					vim.api.nvim_win_set_width(rwin, width)
				end
				set_width()
				vim.g.writemodehl = vim.api.nvim_get_hl(0, { name = "WinSeparator" })
				vim.api.nvim_set_hl(0, "WinSeparator", { fg = "bg" })
				vim.api.nvim_create_autocmd("VimResized", {
					group = vim.api.nvim_create_augroup("writemode", { clear = false }),
					callback = function() set_width() end,
				})
				vim.api.nvim_create_autocmd("WinClosed", {
					pattern = tostring(vim.api.nvim_get_current_win()),
					group = vim.api.nvim_create_augroup("writemode", { clear = false }),
					callback = function()
						Snacks.toggle.get("writemode"):set(false)
						if #vim.api.nvim_list_wins() == 1 then vim.cmd("quit") end
					end,
				})
				local win = vim.api.nvim_get_current_win()
				vim.api.nvim_create_autocmd("BufEnter", {
					pattern = "padding",
					group = vim.api.nvim_create_augroup("writemode", { clear = false }),
					callback = function() vim.api.nvim_set_current_win(win) end,
				})
			else
				Snacks.toggle.get("spell"):set(false)
				Snacks.toggle.get("wrap"):set(false)
				Snacks.toggle.get("number"):set(true)
				Snacks.toggle.get("relativenumber"):set(true)
				Snacks.toggle.get("statuscolumn"):set(true)
				Snacks.toggle.get("signcolumn"):set(true)
				Snacks.toggle.get("indent"):set(true)
				vim.api.nvim_buf_delete(vim.g.writemodebuf, { force = true })
				vim.api.nvim_set_hl(0, "WinSeparator", vim.g.writemodehl)
				vim.api.nvim_clear_autocmds({ group = "writemode" })
			end
			vim.g.writemode = state
		end,
	})

	Snacks.toggle.get("auto_format"):map("<leader>tf")
	Snacks.toggle.get("auto_pairs"):map("<leader>tp")
	Snacks.toggle.get("codelens"):map("<leader>tl")
	Snacks.toggle.get("diagnostics"):map("<leader>td")
	Snacks.toggle.get("inlay_hints"):map("<leader>th")
	Snacks.toggle.get("spell"):map("<leader>ts")

	vim.api.nvim_create_user_command("WriteMode", function()
		local writemode = Snacks.toggle.get("writemode")
		if writemode then writemode:set(not writemode:get()) end
	end, {})

	vim.g.snacks_animate = false

	vim.keymap.set("n", "<leader>bf", Snacks.picker.buffers, { desc = "Find buffer" })
	vim.keymap.set("n", "<leader>ff", Snacks.picker.files, { desc = "Find file" })
	vim.keymap.set("n", "<leader>fr", Snacks.picker.recent, { desc = "Find recent file" })
	vim.keymap.set("n", "<leader>fs", Snacks.picker.grep, { desc = "Search files" })
	vim.keymap.set("n", "<leader>gL", Snacks.picker.git_log_line, { desc = "Git blame line" })
	vim.keymap.set("n", "<leader>gf", Snacks.picker.git_log_file, { desc = "Git log file" })
	vim.keymap.set("n", "<leader>gg", Snacks.lazygit.open, { desc = "Lazygit" })
	vim.keymap.set("n", "<leader>gl", Snacks.picker.git_log, { desc = "Git log" })
	vim.keymap.set("n", "gO", Snacks.picker.lsp_symbols, { desc = "Document symbols" })
	vim.keymap.set("n", "grD", Snacks.picker.lsp_declarations, { desc = "Declaration" })
	vim.keymap.set("n", "grd", Snacks.picker.lsp_definitions, { desc = "Definition" })
	vim.keymap.set("n", "gri", Snacks.picker.lsp_implementations, { desc = "Implementation" })
	vim.keymap.set("n", "grr", Snacks.picker.lsp_references, { nowait = true, desc = "References" })
	vim.keymap.set("n", "grt", Snacks.picker.lsp_type_definitions, { desc = "Type definition" })
	vim.keymap.set({ "n", "i" }, "<F1>", Snacks.picker.help, { desc = "Find help" })
	vim.keymap.set({ "n", "i", "t" }, "<c-/>", Snacks.terminal.toggle, { desc = "Terminal" })
	vim.keymap.set(
		"n",
		"[[",
		function() Snacks.words.jump(-vim.v.count1) end,
		{ desc = "Previous reference" }
	)
	vim.keymap.set(
		"n",
		"]]",
		function() Snacks.words.jump(vim.v.count1) end,
		{ desc = "Next reference" }
	)
end)
