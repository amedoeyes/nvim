return {
	"echasnovski/mini.bufremove",
	lazy = true,
	keys = {
		{ "<leader>br", function() require("mini.bufremove").delete(0, false) end, desc = "Remove buffer" },
		{
			"<leader>bR",
			function()
				for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
					require("mini.bufremove").delete(buffer, false)
				end
			end,
			desc = "Remove all buffers",
		},
	},
}
