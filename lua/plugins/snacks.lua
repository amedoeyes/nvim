return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				local toggle = Snacks.toggle

				toggle.option("spell", { id = "spell", name = "Spell" })
				toggle.option("relativenumber", { id = "relativenumber" })
				toggle.option("cursorline", { id = "cursorline" })
				toggle.option("showtabline", {
					id = "tabline",
					on = vim.opt.showtabline:get(),
					off = 0,
				})
				toggle.option("laststatus", {
					id = "statusline",
					on = vim.opt.laststatus:get(),
					off = 0,
				})
				toggle.option("statuscolumn", {
					id = "statuscolumn",
					on = vim.opt.statuscolumn:get(),
					off = "",
				})
				toggle.option("signcolumn", {
					id = "signcolumn",
					on = vim.opt.signcolumn:get(),
					off = "no",
				})

				toggle.new({
					id = "autopairs",
					name = "Auto-Pairs",
					get = function()
						return not vim.g.minipairs_disable
					end,
					set = function(state)
						vim.g.minipairs_disable = not state
					end,
				})
				toggle.new({
					id = "gitsigns",
					name = "Git Signs",
					get = function()
						return not vim.g.minidiff_disable
					end,
					set = function(state)
						vim.g.minidiff_disable = not state
					end,
				})
				toggle.new({
					id = "autoformat",
					name = "Auto-Format",
					get = function()
						return vim.g.autoformat
					end,
					set = function(state)
						vim.g.autoformat = state
					end,
				})
				toggle.new({
					id = "codelens",
					name = "Codelens",
					get = function()
						return vim.g.codelens
					end,
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
					name = "Write Mode",
					get = function()
						return vim.g.writemode
					end,
					set = function(state)
						if state then
							toggle.get("line_number"):set(false)
							toggle.get("statuscolumn"):set(false)
							toggle.get("signcolumn"):set(false)
						else
							toggle.get("line_number"):set(true)
							toggle.get("statuscolumn"):set(true)
							toggle.get("signcolumn"):set(true)
						end
						vim.g.writemode = state
					end,
				})
				toggle.new({
					id = "screenshotmode",
					name = "Screenshot Mode",
					get = function()
						return vim.g.screenshotmode
					end,
					set = function(state)
						if state then
							toggle.get("relativenumber"):set(false)
							toggle.get("cursorline"):set(false)
							toggle.get("tabline"):set(false)
							toggle.get("statusline"):set(false)
							toggle.get("statusline"):set(false)
							toggle.get("statuscolumn"):set(false)
							toggle.get("signcolumn"):set(false)
							toggle.get("diagnostics"):set(false)
							toggle.get("indent"):set(false)
							toggle.get("words"):set(false)
							vim.api.nvim_set_hl(0, "Cursor", { blend = 100, bg = "white" })
							vim.cmd("NoMatchParen")
						else
							toggle.get("relativenumber"):set(true)
							toggle.get("cursorline"):set(true)
							toggle.get("tabline"):set(true)
							toggle.get("statusline"):set(true)
							toggle.get("statusline"):set(true)
							toggle.get("statuscolumn"):set(true)
							toggle.get("signcolumn"):set(true)
							toggle.get("diagnostics"):set(true)
							toggle.get("indent"):set(true)
							toggle.get("words"):set(true)
							vim.api.nvim_set_hl(0, "Cursor", { blend = 0 })
							vim.cmd("DoMatchParen")
						end
						vim.g.screenshotmode = state
					end,
				})

				toggle.get("autopairs"):map("<leader>Tp")
				toggle.get("codelens"):map("<leader>Tl")
				toggle.get("diagnostics"):map("<leader>Td")
				toggle.get("inlay_hints"):map("<leader>Th")
				toggle.get("spell"):map("<leader>Ts")

				vim.api.nvim_create_user_command("ScreenshotMode", function()
					local screenshotmode = toggle.get("screenshotmode")
					screenshotmode:set(not screenshotmode:get())
				end, {})
				vim.api.nvim_create_user_command("WriteMode", function()
					local writemode = toggle.get("writemode")
					writemode:set(not writemode:get())
				end, {})
				vim.api.nvim_create_user_command("ZenMode", function()
					Snacks.zen()
				end, {})
			end,
		})
	end,
	opts = {
		bigfile = { enabled = true },
		indent = {
			enabled = true,
			animate = { enabled = false },
		},
		input = { enabled = true, icon = "" },
		notifier = {
			enabled = true,
			style = function(buf, notif, ctx)
				ctx.opts.wo.winhighlight = ""
				vim.api.nvim_buf_set_lines(
					buf,
					0,
					-1,
					false,
					vim.split(notif.icon .. " " .. notif.msg, "\n")
				)
			end,
			width = { max = 80 },
			top_down = false,
		},
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = {
			enabled = true,
			debounce = 100,
		},
		zen = { toggles = { dim = false } },
		styles = {
			lazygit = { border = "single" },
			notification = { border = "single", wo = { winblend = 0 } },
			blame_line = { border = "single" },
			zen = { backdrop = { transparent = false } },
			input = {
				relative = "cursor",
				width = 40,
				row = -3,
				col = 0,
				border = "single",
				title_pos = "left",
			},
		},
	},
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit log",
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit current file history",
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git blame line",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git browse",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next reference",
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Previous reference",
		},
	},
}
