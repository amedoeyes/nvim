return {
	"goolord/alpha-nvim",
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		local logo = [[
      ███    ███████    ███
    ███    ███     ███    ███
  ███     ███       ███     ███
███       ███       ███       ███
  ███     ███       ███     ███
    ███    ███     ███    ███
      ███    ███████    ███
		]]

		dashboard.section.header.val = vim.split(logo, "\n")
		dashboard.section.buttons.val = {
			dashboard.button("f", " " .. " Find file", "<CMD>Telescope find_files<CR>"),
			dashboard.button("p", " " .. " Projects", "<CMD>Telescope projects<CR>"),
			dashboard.button("r", " " .. " Recent files", "<CMD>Telescope oldfiles<CR>"),
			dashboard.button("g", " " .. " Find text", "<CMD>Telescope live_grep<CR>"),
			dashboard.button("c", " " .. " Config", "<CMD>e $MYVIMRC<CR>"),
			dashboard.button("s", " " .. " Restore Session", [[<CMD>lua require("persistence").load()<CR>]]),
			dashboard.button("l", "󰒲 " .. " Lazy", "<CMD>Lazy<CR>"),
			dashboard.button("q", " " .. " Quit", "<CMD>qa<CR>"),
		}
		dashboard.opts.layout[1].val = 8

		return dashboard
	end,
	config = function(_, dashboard)
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		require("alpha").setup(dashboard.opts)
	end,
}
