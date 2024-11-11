return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				Snacks.toggle.diagnostics():map("<leader>Td")
				Snacks.toggle.inlay_hints():map("<leader>Th")
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>Ts")
				Snacks.toggle
					.new({
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
					:map("<leader>Tl")
				Snacks.toggle
					.new({
						name = "Auto-Pairs",
						get = function()
							return not vim.g.minipairs_disable
						end,
						set = function(state)
							vim.g.minipairs_disable = not state
						end,
					})
					:map("<leader>Tp")
				Snacks.toggle
					.new({
						name = "Auto-Format",
						get = function()
							return vim.g.autoformat
						end,
						set = function(state)
							vim.g.autoformat = state
						end,
					})
					:map("<leader>Tf")
			end,
		})
	end,
	opts = {
		bigfile = { enabled = true },
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
		words = { enabled = true, debounce = 100 },
		styles = {
			lazygit = { border = "single" },
			notification = {
				border = "single",
				wo = { winblend = 0 },
			},
			blame_line = { border = "single" },
		},
	},
	keys = {
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Remove Buffer",
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
