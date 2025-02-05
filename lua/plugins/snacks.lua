return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				local toggle = Snacks.toggle

				toggle.option("spell", { id = "spell", name = "Spell", global = false })
				toggle.option("wrap", { id = "wrap", global = false })
				toggle.option("number", { id = "number", global = false })
				toggle.option("relativenumber", { id = "relativenumber", global = false })
				toggle.option("cursorline", { id = "cursorline", global = false })
				toggle.option("showtabline", {
					id = "tabline",
					on = vim.opt.showtabline:get(),
					off = 0,
					global = false,
				})
				toggle.option("laststatus", {
					id = "statusline",
					on = vim.opt.laststatus:get(),
					off = 0,
					global = false,
				})
				toggle.option("statuscolumn", {
					id = "statuscolumn",
					on = vim.opt.statuscolumn:get(),
					off = "",
					global = false,
				})
				toggle.option("signcolumn", {
					id = "signcolumn",
					on = vim.opt.signcolumn:get(),
					off = "no",
					global = false,
				})

				toggle.new({
					id = "autopairs",
					name = "Auto-Pairs",
					get = function() return not vim.g.minipairs_disable end,
					set = function(state) vim.g.minipairs_disable = not state end,
				})
				toggle.new({
					id = "gitsigns",
					name = "Git Signs",
					get = function() return not vim.g.minidiff_disable end,
					set = function(state) vim.g.minidiff_disable = not state end,
				})
				toggle.new({
					id = "autoformat",
					name = "Auto-Format",
					get = function() return vim.g.autoformat end,
					set = function(state) vim.g.autoformat = state end,
				})
				toggle.new({
					id = "codelens",
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
				toggle.new({
					id = "writemode",
					name = "Write mode",
					get = function() return vim.g.writemode end,
					set = function(state)
						if state then
							toggle.get("spell"):set(true)
							toggle.get("wrap"):set(true)
							toggle.get("number"):set(false)
							toggle.get("relativenumber"):set(false)
							toggle.get("statuscolumn"):set(false)
							toggle.get("signcolumn"):set(false)
							toggle.get("indent"):set(false)
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
									toggle.get("writemode"):set(false)
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
							toggle.get("spell"):set(false)
							toggle.get("wrap"):set(false)
							toggle.get("number"):set(true)
							toggle.get("relativenumber"):set(true)
							toggle.get("statuscolumn"):set(true)
							toggle.get("signcolumn"):set(true)
							toggle.get("indent"):set(true)
							vim.api.nvim_buf_delete(vim.g.writemodebuf, { force = true })
							vim.api.nvim_set_hl(0, "WinSeparator", vim.g.writemodehl)
							vim.api.nvim_clear_autocmds({ group = "writemode" })
						end
						vim.g.writemode = state
					end,
				})

				toggle.get("autoformat"):map("<leader>tf")
				toggle.get("autopairs"):map("<leader>tp")
				toggle.get("codelens"):map("<leader>tl")
				toggle.get("diagnostics"):map("<leader>td")
				toggle.get("inlay_hints"):map("<leader>th")
				toggle.get("spell"):map("<leader>ts")

				vim.api.nvim_create_user_command("WriteMode", function()
					local writemode = toggle.get("writemode")
					if writemode then writemode:set(not writemode:get()) end
				end, {})
				vim.api.nvim_create_user_command("ZenMode", function() Snacks.zen() end, {})

				vim.g.snacks_animate = false
			end,
		})
	end,
	opts = {
		bigfile = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true, icon = "" },
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
	},
	keys = {
		{ "<F1>", function() Snacks.picker.help() end, desc = "Find help", mode = { "n", "i" } },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		{ "<leader>bf", function() Snacks.picker.buffers() end, desc = "Find buffer" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find file" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Find recent file" },
		{ "<leader>fs", function() Snacks.picker.grep() end, desc = "Search files" },
		{ "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git blame line" },
		{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git log file" },
		{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },
		{ "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Previous reference" },
		{ "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference" },
		{ "gO", function() Snacks.picker.lsp_symbols() end, desc = "Document symbols" },
		{ "grD", function() Snacks.picker.lsp_declarations() end, desc = "Declaration" },
		{ "grd", function() Snacks.picker.lsp_definitions() end, desc = "Definition" },
		{ "gri", function() Snacks.picker.lsp_implementations() end, desc = "Implementation" },
		{ "grr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
		{ "grt", function() Snacks.picker.lsp_type_definitions() end, desc = "Type definition" },
		{ "<c-/>", function() Snacks.terminal() end, desc = "Terminal", mode = { "n", "i", "t" } },
	},
}
